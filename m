Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7191481E06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhL3QTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:19:15 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:41865 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbhL3QTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:19:12 -0500
Received: by mail-qv1-f47.google.com with SMTP id h5so22454521qvh.8;
        Thu, 30 Dec 2021 08:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9hW8ate6wBFif+CCyuvQdudVgJBcFoGFruomLrCbS8=;
        b=Q0IZMC7e3BoEN7JWdsfAXwm4hLfgC9i9DiIzL9ltcUSyhgGaMVMZ7BuKaQv646MOXn
         TplwfIuaUA0GVVQBQZULRqOxtE9vhizDBnHIHjns7GjXfTNrhEBBR2fp3p8mJV/QbBG3
         d6eBzhwGvfyXnZc4Dcsoz4du6RBCN7DBu7Oqz2Yl/EzgfgFK+EqH+yN9i3srPhwbzqTh
         Ah5+7BZ62DGuF4UYYl/2FH/AN+8eYr5iEhZQ1zqH775/kBLHYu/S4gkwmz3H0gxI9oDQ
         7PFdqq5qQPOdBpglIQlkjThx0S2GyQ8VmxK+Bnkwt1QwYExAUDM1aLeqbvz/2QTtRwzd
         0kVQ==
X-Gm-Message-State: AOAM532vgWCjPJQqCMOJl/lwshMRChCxr5pHIXwwk2h9r6qejwXPBOb/
        Yl9cyGmsB1hhRYubj+pr1nlDvafKK7EcCf6N8+wUHPUZ
X-Google-Smtp-Source: ABdhPJwL9u/PoyVyM9tWI3iHmxVXQB4pcDB6Xm3GRHl/6jjlLGxBAEJM6ZPOYl8sZ1Kbh+GfIBBVCFx2BABTH3UeJoA=
X-Received: by 2002:a05:6214:1c06:: with SMTP id u6mr28301080qvc.35.1640881151685;
 Thu, 30 Dec 2021 08:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20211222190919.137550-1-sudeep.holla@arm.com>
In-Reply-To: <20211222190919.137550-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:19:01 +0100
Message-ID: <CAJZ5v0jWJVSFS3KTavfCTzxWq-Q361nGDCWf+VLXRu-9Z4MJsQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCC: Implement OperationRegion handler for the PCC
 Type 3 subtype
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> PCC OpRegion provides a mechanism to communicate with the platform
> directly from the AML. PCCT provides the list of PCC channel available
> in the platform, a subset or all of them can be used in PCC Opregion.
>
> This patch registers the PCC OpRegion handler before ACPI tables are loaded.
> This relies on the special context data passed to identify and setup the
> PCC channel before the OpRegion handler is executed for the first time.
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
> It contains 4 named double words followed by 100 bytes of buffer names DATA.
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
> This buffer is recieved by acpi_pcc_opregion_space_handler. This

received

> handler will fetch the commplete buffer via internal_pcc_buffer.

complete

> The setup handler will receive the special PCC context data which will
> contain the PCC channel index which used to setup the channel. The buffer

set up

> pointer and length is saved in region context which is then used in the
> handler.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/Kconfig        |   5 ++
>  drivers/acpi/Makefile       |   1 +
>  drivers/acpi/bus.c          |   1 +
>  drivers/acpi/pcc_opregion.c | 111 ++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h        |   6 ++
>  5 files changed, 124 insertions(+)
>  create mode 100644 drivers/acpi/pcc_opregion.c
>
> Hi,
>
> This is just resend of [1] rebased on top of [2] as it depends on
> ACPICA changes there as requested by Rafael [3]
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/r/20211102182542.3460787-4-sudeep.holla@arm.com
> [2] https://lore.kernel.org/lkml/11889746.O9o76ZdvQC@kreacher
> [3] https://lore.kernel.org/all/CAJZ5v0jL2+1rzqB2aAJ0T6w3md2dyuHWZNKOk+AbioeD-4ccDA@mail.gmail.com/
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index cdbdf68bd98f..3f56ee8c01be 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -524,6 +524,11 @@ config ACPI_PPTT
>         bool
>  endif
>
> +config ACPI_PCC_OPREGION

I would prefer this to be called ACPI_PCC and the driver file to be
called acpi_pcc.c too.

> +       bool "PCC Opregion"

And this really is "PCC Address Space", isn't it?

> +       depends on PCC
> +       default y
> +
>  source "drivers/acpi/pmic/Kconfig"
>
>  config ACPI_VIOT
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3018714e87d9..d010ed3f4937 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -67,6 +67,7 @@ acpi-$(CONFIG_ACPI_LPIT)      += acpi_lpit.o
>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
>  acpi-$(CONFIG_ACPI_WATCHDOG)   += acpi_watchdog.o
>  acpi-$(CONFIG_ACPI_PRMT)       += prmt.o
> +acpi-$(CONFIG_ACPI_PCC_OPREGION) += pcc_opregion.o
>
>  # Address translation
>  acpi-$(CONFIG_ACPI_ADXL)       += acpi_adxl.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index fa923a929224..5e1eea7fb6f4 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1320,6 +1320,7 @@ static int __init acpi_init(void)
>                 pr_debug("%s: kset create error\n", __func__);
>
>         init_prmt();
> +       init_pcc_opregion();

init_pcc();

>         result = acpi_bus_init();
>         if (result) {
>                 kobject_put(acpi_kobj);
> diff --git a/drivers/acpi/pcc_opregion.c b/drivers/acpi/pcc_opregion.c
> new file mode 100644
> index 000000000000..c965ce555bd0
> --- /dev/null
> +++ b/drivers/acpi/pcc_opregion.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Sudeep Holla <sudeep.holla@arm.com>
> + * Copyright 2021 Arm Limited
> + *
> + * pcc_opregion.c

This is rather unuseful.

Please provide a concise description of the functionality provided by
this driver instead.

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
> +        struct mbox_client cl;
> +       struct acpi_pcc_info ctx;
> +};
> +
> +struct acpi_pcc_info pcc_ctx;
> +
> +static void pcc_rx_callback(struct mbox_client *cl, void *m)
> +{
> +        struct pcc_data *data = container_of(cl, struct pcc_data, cl);
> +
> +       complete(&data->done);
> +}
> +
> +static acpi_status
> +acpi_pcc_opregion_setup(acpi_handle region_handle, u32 function,
> +                       void *handler_context,  void **region_context)

acpi_pcc_address_space_setup(

> +{
> +       struct pcc_data *data;
> +       struct acpi_pcc_info *ctx = handler_context;
> +       struct pcc_mbox_chan *pcc_chan;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return_ACPI_STATUS(AE_NO_MEMORY);
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
> +               return_ACPI_STATUS(AE_NOT_FOUND);
> +       }
> +
> +       pcc_chan = data->pcc_chan;
> +       data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +                                             pcc_chan->shmem_size);
> +       if (!data->pcc_comm_addr) {
> +               pr_err("Failed to ioremap PCC comm region mem for %d\n",
> +                      ctx->subspace_id);
> +               return_ACPI_STATUS(AE_NO_MEMORY);
> +       }
> +
> +       *region_context = data;
> +       return_ACPI_STATUS(AE_OK);
> +}
> +
> +static acpi_status
> +acpi_pcc_opregion_space_handler(u32 function, acpi_physical_address addr,
> +                               u32 bits, acpi_integer *value,
> +                               void *handler_context, void *region_context)

acpi_pcc_address_space_handler(

> +{
> +       int ret;
> +       struct pcc_data* data = region_context;
> +
> +       reinit_completion(&data->done);
> +
> +       /* Write to Shared Memory */
> +       memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
> +
> +       ret = mbox_send_message(data->pcc_chan->mchan, NULL);
> +       if (ret < 0)
> +               return_ACPI_STATUS(AE_ERROR);
> +
> +       if (data->pcc_chan->mchan->mbox->txdone_irq)
> +               wait_for_completion(&data->done);
> +
> +       mbox_client_txdone(data->pcc_chan->mchan, ret);
> +
> +       memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
> +
> +       return_ACPI_STATUS(AE_OK);
> +}
> +
> +void __init init_pcc_opregion(void)

acpi_init_pcc()

> +{
> +       acpi_status status;
> +
> +       status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
> +                                                   ACPI_ADR_SPACE_PLATFORM_COMM,
> +                                                   &acpi_pcc_opregion_space_handler,
> +                                                   &acpi_pcc_opregion_setup,
> +                                                   &pcc_ctx);
> +       if (ACPI_FAILURE(status))
> +               pr_alert("OperationRegion handler could not be installed\n");
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b28f8790192a..348c0de8aa8f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1389,6 +1389,12 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  }
>  #endif
>
> +#ifdef CONFIG_ACPI_PCC_OPREGION
> +void init_pcc_opregion(void);
> +#else
> +static inline void init_pcc_opregion(void) { }
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  extern void acpi_device_notify(struct device *dev);
>  extern void acpi_device_notify_remove(struct device *dev);
> --
