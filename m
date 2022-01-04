Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08547484914
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiADUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:02:44 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:43824 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:02:44 -0500
Received: by mail-qv1-f41.google.com with SMTP id fq10so35404154qvb.10;
        Tue, 04 Jan 2022 12:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anFKTVYgXgO1STf17ZL6DXstvGj5E56uYizpeLigXd4=;
        b=nvu6mdl7kAL9mzdTfrmTRTOv/oWy8ry15zxPI5psl3fDxqIKxJOVOeKicz0WFE3tH1
         BjJNxBRJt7bx81Rzdgne9g2t8BbVkW9kJ88rcemy7x6OdllUy+eFePVc0bmaowsYQd++
         teMvOXCC0OaVM3Xv0sG4CABLUiXyMyiv25KT4HUzzP8iO1qLUgGXs1GkTKxipChcscgK
         MgOkwDhOnbbon/JE8/R34UhEqkwM3N17ZOpJnR9r9rfUl8k8PWToogCeLNVFGfQdOF2Q
         0rCQNi5oYznEj/hqjcO64uc7mXHi3O5b1NEDUb3xbrhmyevrR6Br4tsbnf6OdCN1VNEx
         XLjg==
X-Gm-Message-State: AOAM530WwJFtKJKljpx8Lfn2TNqxLkceDyaS+Yo1WYavjSXMJstFTlhC
        MfESv9XUqP6hGM7imdkPwDdpnM26uhLgIGkp6x0=
X-Google-Smtp-Source: ABdhPJwk5CoW24XpwV+1gNvDY2FWac3BEkqtJZCbTH/WSjQ330FU2SmNH3kdciLYf4b9STh8DczfxufaI5VTHLB2C3s=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr46817595qvd.52.1641326563175;
 Tue, 04 Jan 2022 12:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20220104195108.995359-1-sudeep.holla@arm.com>
In-Reply-To: <20220104195108.995359-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 21:02:32 +0100
Message-ID: <CAJZ5v0gPfEzEHEgWukFF_igAH3U-TOYzPTvrbD9dQjLk=qa65Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: PCC: Implement OperationRegion handler for the
 PCC Type 3 subtype
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 8:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> PCC OpRegion provides a mechanism to communicate with the platform
> directly from the AML. PCCT provides the list of PCC channel available
> in the platform, a subset or all of them can be used in PCC Opregion.
>
> This patch registers the PCC OpRegion handler before ACPI tables are
> loaded. This relies on the special context data passed to identify and
> set up the PCC channel before the OpRegion handler is executed for the
> first time.
>
> Typical PCC Opregion declaration looks like this:
>
> OperationRegion (PFRM, PCC, 2, 0x74)
> Field (PFRM, ByteAcc, NoLock, Preserve)
> {
>     SIGN,   32,
>     FLGS,   32,
>     LEN,    32,
>     CMD,    32,
>     DATA,   800
> }
>
> It contains four named double words followed by 100 bytes of buffer
> names DATA.
>
> ASL can fill out the buffer something like:
>
>     /* Create global or local buffer */
>     Name (BUFF, Buffer (0x0C){})
>     /* Create double word fields over the buffer */
>     CreateDWordField (BUFF, 0x0, WD0)
>     CreateDWordField (BUFF, 0x04, WD1)
>     CreateDWordField (BUFF, 0x08, WD2)
>
>     /* Fill the named fields */
>     WD0 = 0x50434300
>     SIGN = BUFF
>     WD0 = 1
>     FLGS = BUFF
>     WD0 = 0x10
>     LEN = BUFF
>
>     /* Fill the payload in the DATA buffer */
>     WD0 = 0
>     WD1 = 0x08
>     WD2 = 0
>     DATA = BUFF
>
>     /* Write to CMD field to trigger handler */
>     WD0 = 0x4404
>     CMD = BUFF
>
> This buffer is received by acpi_pcc_opregion_space_handler. This
> handler will fetch the complete buffer via internal_pcc_buffer.
>
> The setup handler will receive the special PCC context data which will
> contain the PCC channel index which used to set up the channel. The
> buffer pointer and length is saved in region context which is then used
> in the handler.
>
> (kernel test robot: Build failure with CONFIG_ACPI_DEBUGGER)
> Link: https://lore.kernel.org/r/202201041539.feAV0l27-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 5.17 material, thanks!

> ---
>  drivers/acpi/Kconfig    |  17 ++++++
>  drivers/acpi/Makefile   |   1 +
>  drivers/acpi/acpi_pcc.c | 120 ++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c      |   1 +
>  include/linux/acpi.h    |   6 ++
>  5 files changed, 145 insertions(+)
>  create mode 100644 drivers/acpi/acpi_pcc.c
>
> v2[2]-v3:
>         - Fixed build with CONFIG_ACPI_DEBUGGER enabled
>           Looks like return_ACPI_STATUS is supposed to be used only
>           in core ACPICA
>
> v1[0]-v2[2]:
>         - Addressed all the comments from Rafael[1]
>
> [0] https://lore.kernel.org/r/20211222190919.137550-1-sudeep.holla@arm.com/
> [1] https://lore.kernel.org/r/CAJZ5v0jWJVSFS3KTavfCTzxWq-Q361nGDCWf+VLXRu-9Z4MJsQ@mail.gmail.com
> [2] https://lore.kernel.org/r/20220103155838.616580-1-sudeep.holla@arm.com
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 91f1da16934d..8cdc7860b6e6 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -546,6 +546,23 @@ config ACPI_PPTT
>         bool
>  endif
>
> +config ACPI_PCC
> +       bool "ACPI PCC Address Space"
> +       depends on PCC
> +       default y
> +       help
> +         The PCC Address Space also referred as PCC Operation Region pertains
> +         to the region of PCC subspace that succeeds the PCC signature.
> +
> +         The PCC Operation Region works in conjunction with the PCC Table
> +         (Platform Communications Channel Table). PCC subspaces that are
> +         marked for use as PCC Operation Regions must not be used as PCC
> +         subspaces for the standard ACPI features such as CPPC, RASF, PDTT and
> +         MPST. These standard features must always use the PCC Table instead.
> +
> +         Enable this feature if you want to set up and install the PCC Address
> +         Space handler to handle PCC OpRegion in the firmware.
> +
>  source "drivers/acpi/pmic/Kconfig"
>
>  config ACPI_VIOT
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d3dc79298ce3..f47032769f69 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -67,6 +67,7 @@ acpi-$(CONFIG_ACPI_LPIT)      += acpi_lpit.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)   += acpi_watchdog.o
>  acpi-$(CONFIG_ACPI_PRMT)       += prmt.o
> +acpi-$(CONFIG_ACPI_PCC)                += acpi_pcc.o
>
>  # Address translation
>  acpi-$(CONFIG_ACPI_ADXL)       += acpi_adxl.o
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> new file mode 100644
> index 000000000000..41e3ebd204ff
> --- /dev/null
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Sudeep Holla <sudeep.holla@arm.com>
> + * Copyright 2021 Arm Limited
> + *
> + * The PCC Address Space also referred as PCC Operation Region pertains to the
> + * region of PCC subspace that succeeds the PCC signature. The PCC Operation
> + * Region works in conjunction with the PCC Table(Platform Communications
> + * Channel Table). PCC subspaces that are marked for use as PCC Operation
> + * Regions must not be used as PCC subspaces for the standard ACPI features
> + * such as CPPC, RASF, PDTT and MPST. These standard features must always use
> + * the PCC Table instead.
> + *
> + * This driver sets up the PCC Address Space and installs an handler to enable
> + * handling of PCC OpRegion in the firmware.
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/completion.h>
> +#include <linux/idr.h>
> +#include <linux/io.h>
> +
> +#include <acpi/pcc.h>
> +
> +struct pcc_data {
> +       struct pcc_mbox_chan *pcc_chan;
> +       void __iomem *pcc_comm_addr;
> +       struct completion done;
> +       struct mbox_client cl;
> +       struct acpi_pcc_info ctx;
> +};
> +
> +struct acpi_pcc_info pcc_ctx;
> +
> +static void pcc_rx_callback(struct mbox_client *cl, void *m)
> +{
> +       struct pcc_data *data = container_of(cl, struct pcc_data, cl);
> +
> +       complete(&data->done);
> +}
> +
> +static acpi_status
> +acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
> +                            void *handler_context,  void **region_context)
> +{
> +       struct pcc_data *data;
> +       struct acpi_pcc_info *ctx = handler_context;
> +       struct pcc_mbox_chan *pcc_chan;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return AE_NO_MEMORY;
> +
> +       data->cl.rx_callback = pcc_rx_callback;
> +       data->cl.knows_txdone = true;
> +       data->ctx.length = ctx->length;
> +       data->ctx.subspace_id = ctx->subspace_id;
> +       data->ctx.internal_buffer = ctx->internal_buffer;
> +
> +       init_completion(&data->done);
> +       data->pcc_chan = pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
> +       if (IS_ERR(data->pcc_chan)) {
> +               pr_err("Failed to find PCC channel for subspace %d\n",
> +                      ctx->subspace_id);
> +               return AE_NOT_FOUND;
> +       }
> +
> +       pcc_chan = data->pcc_chan;
> +       data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +                                             pcc_chan->shmem_size);
> +       if (!data->pcc_comm_addr) {
> +               pr_err("Failed to ioremap PCC comm region mem for %d\n",
> +                      ctx->subspace_id);
> +               return AE_NO_MEMORY;
> +       }
> +
> +       *region_context = data;
> +       return AE_OK;
> +}
> +
> +static acpi_status
> +acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
> +                              u32 bits, acpi_integer *value,
> +                              void *handler_context, void *region_context)
> +{
> +       int ret;
> +       struct pcc_data *data = region_context;
> +
> +       reinit_completion(&data->done);
> +
> +       /* Write to Shared Memory */
> +       memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
> +
> +       ret = mbox_send_message(data->pcc_chan->mchan, NULL);
> +       if (ret < 0)
> +               return AE_ERROR;
> +
> +       if (data->pcc_chan->mchan->mbox->txdone_irq)
> +               wait_for_completion(&data->done);
> +
> +       mbox_client_txdone(data->pcc_chan->mchan, ret);
> +
> +       memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
> +
> +       return AE_OK;
> +}
> +
> +void __init acpi_init_pcc(void)
> +{
> +       acpi_status status;
> +
> +       status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
> +                                                   ACPI_ADR_SPACE_PLATFORM_COMM,
> +                                                   &acpi_pcc_address_space_handler,
> +                                                   &acpi_pcc_address_space_setup,
> +                                                   &pcc_ctx);
> +       if (ACPI_FAILURE(status))
> +               pr_alert("OperationRegion handler could not be installed\n");
> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index dd535b4b9a16..75a61626eddd 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1320,6 +1320,7 @@ static int __init acpi_init(void)
>                 pr_debug("%s: kset create error\n", __func__);
>
>         init_prmt();
> +       acpi_init_pcc();
>         result = acpi_bus_init();
>         if (result) {
>                 kobject_put(acpi_kobj);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6c0798db6bde..eaeb4b9255bc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1389,6 +1389,12 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  }
>  #endif
>
> +#ifdef CONFIG_ACPI_PCC
> +void acpi_init_pcc(void);
> +#else
> +static inline void acpi_init_pcc(void) { }
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  extern void acpi_device_notify(struct device *dev);
>  extern void acpi_device_notify_remove(struct device *dev);
>
> base-commit: 7a716cec17d19211715a34b426aafc3fadb22de6
> --
> 2.25.1
>
