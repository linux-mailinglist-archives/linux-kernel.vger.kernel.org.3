Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858F94AEF24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiBIKTU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiBIKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:19:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30DE11A551;
        Wed,  9 Feb 2022 02:14:32 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jtwgk26rmz67ZJR;
        Wed,  9 Feb 2022 18:13:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 9 Feb 2022 11:13:24 +0100
Received: from localhost (10.47.75.34) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 10:13:23 +0000
Date:   Wed, 9 Feb 2022 10:13:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20220209101320.00000473@Huawei.com>
In-Reply-To: <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-4-ira.weiny@intel.com>
        <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.75.34]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 16:59:39 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Jan 31, 2022 at 11:20 PM <ira.weiny@intel.com> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> >
> > Define an auxiliary device driver which control DOE auxiliary devices  
> 
> s/control/controls/
> 
> > registered on the auxiliary bus.
> >
> > A DOE mailbox is allowed to support any number of protocols while some
> > DOE protocol specifications apply additional restrictions.
> >
> > The protocols supported are queried and cached.  pci_doe_supports_prot()
> > can be used to determine if the DOE device supports the protocol
> > specified.
> >
> > A synchronous interface is provided in pci_doe_exchange_sync() to
> > perform a single query / response exchange from the driver through the
> > device specified.
> >
> > Testing was conducted against QEMU using:
> >
> > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/
> >
> > This code is based on Jonathan's V4 series here:
> >
> > https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/
> >
> > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> >     Data Object Exchange (DOE) - Approved 12 March 2020
> >
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Replies to some comments inline. 



> >
> > ---
> > NOTE: Bjorn mentioned that the signed off by's are backwards but
> >         checkpatch complains no mater what I do.  Either the
> >         co-developed by is wrong or the signed off by is wrong because
> >         Jonathan is the original author.  The above order is acceptable
> >         to checkpatch so I left it that way.
> >
> > Changes from V5
> >         From Bjorn
> >                 s/pci_WARN/pci_warn
> >                         Add timeout period to print
> >                 Trim to 80 chars
> >                 Use Tabs for DOE define spacing
> >                 Use %#x for clarity
> >         From Jonathan
> >                 Addresses concerns about the order of unwinding stuff
> >                 s/doe/doe_dev in pci_doe_exhcnage_sync
> >                 Correct kernel Doc comment
> >                 Move pci_doe_task_complete() down in the file.
> >                 Rework pci_doe_irq()
> >                         process STATUS_ERROR first
> >                         Return IRQ_NONE if the irq is not processed
> >                         Use PCI_DOE_STATUS_INT_STATUS explicitly to
> >                                 clear the irq
> >         Clean up goto label s/err_free_irqs/err_free_irq
> >         use devm_kzalloc for doe struct
> >         clean up error paths in pci_doe_probe
> >         s/pci_doe_drv/pci_doe
> >         remove include mutex.h
> >         remove device name and define, move it in the next patch which uses it
> >         use devm_kasprintf() for irq_name
> >         use devm_request_irq()
> >         remove pci_doe_unregister()
> >                 [get/put]_device() were unneeded and with the use of
> >                 devm_* this function can be removed completely.
> >         refactor pci_doe_register and s/pci_doe_register/pci_doe_reg_irq
> >                 make this function just a registration of the irq and
> >                 move pci_doe_abort() into pci_doe_probe()
> >         use devm_* to allocate the protocol array
> >
> > Changes from Jonathan's V4
> >         Move the DOE MB code into the DOE auxiliary driver
> >         Remove Task List in favor of a wait queue
> >
> > Changes from Ben
> >         remove CXL references
> >         propagate rc from pci functions on error
> > ---
> >  drivers/pci/Kconfig           |  10 +
> >  drivers/pci/Makefile          |   3 +
> >  drivers/pci/doe.c             | 675 ++++++++++++++++++++++++++++++++++
> >  include/linux/pci-doe.h       |  60 +++
> >  include/uapi/linux/pci_regs.h |  29 +-
> >  5 files changed, 776 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/doe.c
> >  create mode 100644 include/linux/pci-doe.h
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 43e615aa12ff..8de51b64067c 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -118,6 +118,16 @@ config XEN_PCIDEV_FRONTEND
> >           The PCI device frontend driver allows the kernel to import arbitrary
> >           PCI devices from a PCI backend to support PCI driver domains.
> >
> > +config PCI_DOE_DRIVER
> > +       tristate "PCI Data Object Exchange (DOE) driver"
> > +       select AUXILIARY_BUS  
> 
> See below near the comment about the odd usage of MODULE_DEVICE_TABLE,
> perhaps the auxiliary device / driver should be registered by the
> client of this core code, not the core itself.
> 
> > +       help
> > +         Driver for DOE auxiliary devices.
> > +
> > +         DOE provides a simple mailbox in PCI config space that is used by a
> > +         number of different protocols.  DOE is defined in the Data Object
> > +         Exchange ECN to the PCIe r5.0 spec.
> > +
> >  config PCI_ATS
> >         bool
> >
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index d62c4ac4ae1b..afd9d7bd2b82 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -28,8 +28,11 @@ obj-$(CONFIG_PCI_STUB)               += pci-stub.o
> >  obj-$(CONFIG_PCI_PF_STUB)      += pci-pf-stub.o
> >  obj-$(CONFIG_PCI_ECAM)         += ecam.o
> >  obj-$(CONFIG_PCI_P2PDMA)       += p2pdma.o
> > +obj-$(CONFIG_PCI_DOE_DRIVER)   += pci-doe.o
> >  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >
> > +pci-doe-y := doe.o
> > +
> >  # Endpoint library must be initialized before its users
> >  obj-$(CONFIG_PCI_ENDPOINT)     += endpoint/
> >
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > new file mode 100644
> > index 000000000000..4ff54bade8ec
> > --- /dev/null
> > +++ b/drivers/pci/doe.c
> > @@ -0,0 +1,675 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Data Object Exchange ECN
> > + * https://members.pcisig.com/wg/PCI-SIG/document/14143
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/module.h>
> > +
> > +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> > +
> > +#define PCI_DOE_BUSY_MAX_RETRIES 16
> > +#define PCI_DOE_POLL_INTERVAL (HZ / 128)
> > +
> > +/* Timeout of 1 second from 6.xx.1 (Operation), ECN - Data Object Exchange */
> > +#define PCI_DOE_TIMEOUT HZ
> > +
> > +enum pci_doe_state {
> > +       DOE_IDLE,
> > +       DOE_WAIT_RESP,
> > +       DOE_WAIT_ABORT,
> > +       DOE_WAIT_ABORT_ON_ERR,
> > +};
> > +
> > +/**
> > + * struct pci_doe_task - description of a query / response task
> > + * @ex: The details of the task to be done
> > + * @rv: Return value.  Length of received response or error
> > + * @cb: Callback for completion of task
> > + * @private: Private data passed to callback on completion
> > + */
> > +struct pci_doe_task {
> > +       struct pci_doe_exchange *ex;
> > +       int rv;
> > +       void (*cb)(void *private);  
> 
> s/cb/end_task/?
> 
> Why does this need to abandon all semblance of type safety?
> 
> I would expect:
> 
> void (*end_task)(struct pci_doe_task *task);
> 
> ...and let the caller attach any follow on data to task->private if necessary.
> 

Sure. can do that. 

> > +       void *private;
> > +};
> > +
> > +/**
> > + * struct pci_doe - A single DOE mailbox driver  
> 
> This is driver *state*, right? I.e. not something that wraps "struct
> device_driver" which is what I would expect something claiming to be a
> "driver" would do.

Agreed.

> 
> > + *
> > + * @doe_dev: The DOE Auxiliary device being driven
> > + * @abort_c: Completion used for initial abort handling
> > + * @irq: Interrupt used for signaling DOE ready or abort
> > + * @irq_name: Name used to identify the irq for a particular DOE
> > + * @prots: Array of identifiers for protocols supported  
> 
> "prot" already has a meaning in the kernel, just spell out
> "protocols". This also looks like something that can be allocated
> inline rather than out of line i.e.:
> 
> struct pci_doe {
> ...
>     int nr_protocols
>     struct pci_doe_protocol protocols[];
> }
> 
> ...and then use struct_size() to allocate it.

Can't do that. The size isn't known when we first start using
this structure - We need to use it to query what protocols are
supported.  It's initially set to 1 to cover the discovery
protocol and then we realloc to expand it as we discover more
protocols.

> 
> > + * @num_prots: Size of prots array
> > + * @cur_task: Current task the state machine is working on
> > + * @wq: Wait queue to wait on if a query is in progress
> > + * @state_lock: Protect the state of cur_task, abort, and dead
> > + * @statemachine: Work item for the DOE state machine
> > + * @state: Current state of this DOE
> > + * @timeout_jiffies: 1 second after GO set
> > + * @busy_retries: Count of retry attempts
> > + * @abort: Request a manual abort (e.g. on init)
> > + * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
> > + *        will immediately be aborted with error
> > + */
> > +struct pci_doe {
> > +       struct pci_doe_dev *doe_dev;
> > +       struct completion abort_c;
> > +       int irq;
> > +       char *irq_name;
> > +       struct pci_doe_protocol *prots;
> > +       int num_prots;
> > +
> > +       struct pci_doe_task *cur_task;
> > +       wait_queue_head_t wq;
> > +       struct mutex state_lock;
> > +       struct delayed_work statemachine;
> > +       enum pci_doe_state state;
> > +       unsigned long timeout_jiffies;
> > +       unsigned int busy_retries;
> > +       unsigned int abort:1;
> > +       unsigned int dead:1;
> > +};
> > +
> > +static irqreturn_t pci_doe_irq(int irq, void *data)
> > +{
> > +       struct pci_doe *doe = data;
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       u32 val;
> > +
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +       /* Leave the error case to be handled outside IRQ */
> > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +               mod_delayed_work(system_wq, &doe->statemachine, 0);
> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > +                                       PCI_DOE_STATUS_INT_STATUS);
> > +               mod_delayed_work(system_wq, &doe->statemachine, 0);
> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       return IRQ_NONE;
> > +}
> > +
> > +/*
> > + * Only call when safe to directly access the DOE, either because no tasks yet
> > + * queued, or called from doe_statemachine_work() which has exclusive access to
> > + * the DOE config space.  
> 
> It doesn't have exclusive access unless the patch to lock out
> userspace config writes are revived. Instead, I like Bjorn's idea of
> tracking and warning / tainting, but not blocking conflicting
> userspace access to sensitive configuration registers.
> 
> Yes, it was somewhat of a throw-away comment from Bjorn in that
> thread, "(and IMO should taint the kernel)", but DOE can do so much
> subtle damage (compliance test modes, link-encryption / disruption,
> vendor private who-knows-what...) that I think it behooves us as
> kernel developers to know when we are debugging system behavior that
> may be the result of non-kernel mitigated DOE access. The proposal is
> that when kernel lockdown is not enabled, use the approach from the
> exclusive config access patch [2] to trap, warn (once per device?),
> and taint when userspace writes to DOE registers that have been
> claimed by the kernel. This lets strict environments use
> kernel-lockdown to block userspace DOE access altogether, in
> non-strict environment it discourages userspace from clobbering DOE
> driver state, and it allows a warn-free path if userspace takes the
> step of at least unbinding the kernel DOE driver before running
> userspace DOE cycles.
> 
> [1]: https://lore.kernel.org/r/20211203235617.GA3036259@bhelgaas
> [2]: https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/

Good info. I'd missed some of the subtle parts of that discussion.

> 
> > + */
> > +static void pci_doe_abort_start(struct pci_doe *doe)
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       u32 val;
> > +
> > +       val = PCI_DOE_CTRL_ABORT;
> > +       if (doe->irq)
> > +               val |= PCI_DOE_CTRL_INT_EN;
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > +
> > +       doe->timeout_jiffies = jiffies + HZ;
> > +       schedule_delayed_work(&doe->statemachine, HZ);  
> 
> Given the spec timeout is 1 second and the device clock might be
> slightly off from the host clock how about make this a more generous
> 1.5 or 2 seconds?

Makes sense. Though if a clock is bad enough we need 2 seconds that
is pretty awful! :)

> 
> > +}
> > +
> > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)  
> 
> The relationship between tasks, requests, responses, and exchanges is
> not immediately clear to me. For example, can this helper be renamed
> in terms of its relationship to a task? A theory of operation document
> would help, but it seems there is also room for the implementation to
> be more self documenting.

Not totally sure what such naming would be.

A task is the management wrapper around an exchange which is a request
+ response pair.  In the sense you queue a task which will carry out
and exchange by sending a request and receiving a response.

Could rename this pci_doe_start_exchange() but that then obscures
that we mean send the request to the hardware and removes the resemblance
to what I recall the specification uses.

> 
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       u32 val;
> > +       int i;
> > +
> > +       /*
> > +        * Check the DOE busy bit is not set. If it is set, this could indicate
> > +        * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > +        * it is expected that firmware and OS will negotiate access rights via
> > +        * an, as yet to be defined method.
> > +        */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +       if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > +               return -EBUSY;
> > +
> > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +               return -EIO;
> > +
> > +       /* Write DOE Header */
> > +       val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, ex->prot.vid) |
> > +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, ex->prot.type);
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> > +       /* Length is 2 DW of header + length of payload in DW */
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +                              FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> > +                                         2 + ex->request_pl_sz /
> > +                                               sizeof(u32)));
> > +       for (i = 0; i < ex->request_pl_sz / sizeof(u32); i++)
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +                                      ex->request_pl[i]);
> > +
> > +       val = PCI_DOE_CTRL_GO;
> > +       if (doe->irq)
> > +               val |= PCI_DOE_CTRL_INT_EN;
> > +
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > +       /* Request is sent - now wait for poll or IRQ */
> > +       return 0;
> > +}
> > +
> > +static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       size_t length;
> > +       u32 val;
> > +       int i;
> > +
> > +       /* Read the first dword to get the protocol */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +       if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->prot.vid) ||
> > +           (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->prot.type)) {
> > +               pci_err(pdev,
> > +                       "Expected [VID, Protocol] = [%#x, %#x], got [%#x, %#x]\n",
> > +                       ex->prot.vid, ex->prot.type,
> > +                       FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> > +                       FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> > +               return -EIO;
> > +       }
> > +
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       /* Read the second dword to get the length */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +
> > +       length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> > +       if (length > SZ_1M || length < 2)
> > +               return -EIO;
> > +
> > +       /* First 2 dwords have already been read */
> > +       length -= 2;
> > +       /* Read the rest of the response payload */
> > +       for (i = 0; i < min(length, ex->response_pl_sz / sizeof(u32)); i++) {
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > +                                     &ex->response_pl[i]);
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       }
> > +
> > +       /* Flush excess length */
> > +       for (; i < length; i++) {
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       }
> > +       /* Final error check to pick up on any since Data Object Ready */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +               return -EIO;
> > +
> > +       return min(length, ex->response_pl_sz / sizeof(u32)) * sizeof(u32);
> > +}
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +       struct delayed_work *w = to_delayed_work(work);
> > +       struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       struct pci_doe_task *task;
> > +       bool abort;
> > +       u32 val;
> > +       int rc;
> > +
> > +       mutex_lock(&doe->state_lock);
> > +       task = doe->cur_task;
> > +       abort = doe->abort;
> > +       doe->abort = false;
> > +       mutex_unlock(&doe->state_lock);
> > +
> > +       if (abort) {
> > +               /*
> > +                * Currently only used during init - care needed if
> > +                * pci_doe_abort() is generally exposed as it would impact
> > +                * queries in flight.
> > +                */
> > +               WARN_ON(task);  
> 
> Why is it worth potentially crashing the kernel here? Is this purely a
> situation that will only happen during development  and refactoring of
> the driver? Otherwise I would expect handling the error without WARN.

From what I recall driver bug only.

> 
> 
> > +               doe->state = DOE_WAIT_ABORT;
> > +               pci_doe_abort_start(doe);
> > +               return;
> > +       }
> > +
> > +       switch (doe->state) {
> > +       case DOE_IDLE:
> > +               if (task == NULL)
> > +                       return;
> > +
> > +               /* Nothing currently in flight so queue a task */
> > +               rc = pci_doe_send_req(doe, task->ex);
> > +               /*
> > +                * The specification does not provide any guidance on how long
> > +                * some other entity could keep the DOE busy, so try for 1
> > +                * second then fail. Busy handling is best effort only, because
> > +                * there is no way of avoiding racing against another user of
> > +                * the DOE.
> > +                */
> > +               if (rc == -EBUSY) {
> > +                       doe->busy_retries++;
> > +                       if (doe->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> > +                               /* Long enough, fail this request */
> > +                               pci_warn(pdev,
> > +                                       "DOE busy for too long (> 1 sec)\n");
> > +                               doe->busy_retries = 0;
> > +                               goto err_busy;
> > +                       }
> > +                       schedule_delayed_work(w, HZ / PCI_DOE_BUSY_MAX_RETRIES);
> > +                       return;
> > +               }
> > +               if (rc)
> > +                       goto err_abort;
> > +               doe->busy_retries = 0;
> > +
> > +               doe->state = DOE_WAIT_RESP;
> > +               doe->timeout_jiffies = jiffies + HZ;
> > +               /* Now poll or wait for IRQ with timeout */
> > +               if (doe->irq > 0)
> > +                       schedule_delayed_work(w, PCI_DOE_TIMEOUT);
> > +               else
> > +                       schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> > +               return;
> > +
> > +       case DOE_WAIT_RESP:
> > +               /* Not possible to get here with NULL task */
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +               if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +                       rc = -EIO;
> > +                       goto err_abort;
> > +               }
> > +
> > +               if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > +                       /* If not yet at timeout reschedule otherwise abort */
> > +                       if (time_after(jiffies, doe->timeout_jiffies)) {
> > +                               rc = -ETIMEDOUT;
> > +                               goto err_abort;
> > +                       }
> > +                       schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> > +                       return;
> > +               }
> > +
> > +               rc  = pci_doe_recv_resp(doe, task->ex);
> > +               if (rc < 0)
> > +                       goto err_abort;
> > +
> > +               doe->state = DOE_IDLE;
> > +
> > +               mutex_lock(&doe->state_lock);
> > +               doe->cur_task = NULL;
> > +               mutex_unlock(&doe->state_lock);
> > +               wake_up_interruptible(&doe->wq);
> > +
> > +               /* Set the return value to the length of received payload */
> > +               task->rv = rc;
> > +               task->cb(task->private);
> > +
> > +               return;
> > +
> > +       case DOE_WAIT_ABORT:
> > +       case DOE_WAIT_ABORT_ON_ERR:
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +               if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > +                       /* Back to normal state - carry on */
> > +                       mutex_lock(&doe->state_lock);
> > +                       doe->cur_task = NULL;
> > +                       mutex_unlock(&doe->state_lock);
> > +                       wake_up_interruptible(&doe->wq);
> > +
> > +                       /*
> > +                        * For deliberately triggered abort, someone is
> > +                        * waiting.
> > +                        */
> > +                       if (doe->state == DOE_WAIT_ABORT)
> > +                               complete(&doe->abort_c);  
> 
> Why is a completion and waitqueue needed? I.e. a waiter could simply
> look for an abort completion flag to be set instead.

You mean use the main completion (the one for the non abort case)
and a flag? 

Or a wait_event() with appropriate check?

Could do that but I'm not sure I understand why we care either way?

> 
> 
> > +
> > +                       doe->state = DOE_IDLE;
> > +                       return;
> > +               }
> > +               if (time_after(jiffies, doe->timeout_jiffies)) {
> > +                       /* Task has timed out and is dead - abort */
> > +                       pci_err(pdev, "DOE ABORT timed out\n");
> > +                       mutex_lock(&doe->state_lock);
> > +                       doe->dead = true;
> > +                       doe->cur_task = NULL;
> > +                       mutex_unlock(&doe->state_lock);
> > +                       wake_up_interruptible(&doe->wq);
> > +
> > +                       if (doe->state == DOE_WAIT_ABORT)
> > +                               complete(&doe->abort_c);
> > +               }
> > +               return;
> > +       }
> > +
> > +err_abort:
> > +       doe->state = DOE_WAIT_ABORT_ON_ERR;
> > +       pci_doe_abort_start(doe);
> > +err_busy:
> > +       task->rv = rc;
> > +       task->cb(task->private);
> > +       /* If here via err_busy, signal the task done. */
> > +       if (doe->state == DOE_IDLE) {
> > +               mutex_lock(&doe->state_lock);
> > +               doe->cur_task = NULL;
> > +               mutex_unlock(&doe->state_lock);
> > +               wake_up_interruptible(&doe->wq);
> > +       }
> > +}
> > +
> > +static void pci_doe_task_complete(void *private)
> > +{
> > +       complete(private);
> > +}
> > +
> > +/**
> > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a
> > + *                          response
> > + * @doe_dev: DOE mailbox state structure
> > + * @ex: Description of the buffers and Vendor ID + type used in this
> > + *      request/response pair
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: payload in bytes on success, < 0 on error
> > + */
> > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
> > +                         struct pci_doe_exchange *ex)
> > +{
> > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > +       struct pci_doe_task task;
> > +       DECLARE_COMPLETION_ONSTACK(c);
> > +
> > +       if (!doe)
> > +               return -EAGAIN;
> > +
> > +       /* DOE requests must be a whole number of DW */
> > +       if (ex->request_pl_sz % sizeof(u32))
> > +               return -EINVAL;
> > +
> > +       task.ex = ex;
> > +       task.cb = pci_doe_task_complete;
> > +       task.private = &c;
> > +
> > +again:
> > +       mutex_lock(&doe->state_lock);
> > +       if (doe->cur_task) {
> > +               mutex_unlock(&doe->state_lock);
> > +               wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > +               goto again;
> > +       }
> > +
> > +       if (doe->dead) {
> > +               mutex_unlock(&doe->state_lock);
> > +               return -EIO;
> > +       }
> > +       doe->cur_task = &task;
> > +       schedule_delayed_work(&doe->statemachine, 0);
> > +       mutex_unlock(&doe->state_lock);
> > +
> > +       wait_for_completion(&c);  
> 
> I would expect that the caller of this routine would want to specify
> the task and end_task() callback and use that as the completion
> signal. It may also want "no wait" behavior where it is prepared for
> the DOE result to come back sometime later. With that change the
> exchange fields can move into the task directly.

This is the simple synchronous wrapper around an async core.
If we want an async path at somepoint in the future where we have
someone using it then sure, we can have an async version that
takes the callback.

> 
> > +
> > +       return task.rv;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);
> > +
> > +/**
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > + *                          protocol
> > + * @pdev: Device on which to find the DOE instance
> > + * @vid: Protocol Vendor ID
> > + * @type: protocol type
> > + *
> > + * This device can then be passed to pci_doe_exchange_sync() to execute a
> > + * mailbox exchange through that DOE mailbox.
> > + *
> > + * RETURNS: True if the DOE device supports the protocol specified
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type)
> > +{
> > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > +       int i;
> > +
> > +       if (!doe)
> > +               return false;
> > +
> > +       for (i = 0; i < doe->num_prots; i++)
> > +               if ((doe->prots[i].vid == vid) &&
> > +                   (doe->prots[i].type == type))
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > +
> > +static int pci_doe_discovery(struct pci_doe *doe, u8 *index, u16 *vid,
> > +                            u8 *protocol)
> > +{
> > +       u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > +                                   *index);
> > +       u32 response_pl;
> > +       struct pci_doe_exchange ex = {
> > +               .prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > +               .prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > +               .request_pl = &request_pl,
> > +               .request_pl_sz = sizeof(request_pl),
> > +               .response_pl = &response_pl,
> > +               .response_pl_sz = sizeof(response_pl),
> > +       };
> > +       int ret;
> > +
> > +       ret = pci_doe_exchange_sync(doe->doe_dev, &ex);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (ret != sizeof(response_pl))
> > +               return -EIO;
> > +
> > +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > +                             response_pl);
> > +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> > +                          response_pl);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pci_doe_cache_protocols(struct pci_doe *doe)
> > +{
> > +       u8 index = 0;
> > +       int num_prots;
> > +       int rc;
> > +
> > +       /* Discovery protocol must always be supported and must report itself */
> > +       num_prots = 1;
> > +       doe->prots = devm_kcalloc(&doe->doe_dev->adev.dev, num_prots,
> > +                                 sizeof(*doe->prots), GFP_KERNEL);
> > +       if (doe->prots == NULL)
> > +               return -ENOMEM;
> > +
> > +       do {
> > +               struct pci_doe_protocol *prot;
> > +
> > +               prot = &doe->prots[num_prots - 1];
> > +               rc = pci_doe_discovery(doe, &index, &prot->vid, &prot->type);
> > +               if (rc)
> > +                       return rc;
> > +
> > +               if (index) {
> > +                       struct pci_doe_protocol *prot_new;
> > +
> > +                       num_prots++;
> > +                       prot_new = devm_krealloc(&doe->doe_dev->adev.dev,
> > +                                                doe->prots,
> > +                                                sizeof(*doe->prots) *
> > +                                                       num_prots,
> > +                                                GFP_KERNEL);
> > +                       if (prot_new == NULL)
> > +                               return -ENOMEM;
> > +                       doe->prots = prot_new;
> > +               }
> > +       } while (index);
> > +
> > +       doe->num_prots = num_prots;
> > +       return 0;
> > +}
> > +
> > +static int pci_doe_abort(struct pci_doe *doe)
> > +{
> > +       reinit_completion(&doe->abort_c);
> > +       mutex_lock(&doe->state_lock);
> > +       doe->abort = true;  
> 
> Why not a flags field where atomic bitops can be used without need for a mutex.

I'll go the other way, why bother with atomics when this isn't a high performance
path or something expected to happen often?

> 
> > +       mutex_unlock(&doe->state_lock);
> > +       schedule_delayed_work(&doe->statemachine, 0);
> > +       wait_for_completion(&doe->abort_c);
> > +
> > +       if (doe->dead)  
> 
> dead could also be another atomic flag.

Probably true, but I'm really not getting why that would be a beneficial
thing to do.

> 
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +static int pci_doe_reg_irq(struct pci_doe *doe)
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       bool poll = !pci_dev_msi_enabled(pdev);
> > +       int offset = doe->doe_dev->cap_offset;
> > +       int rc, irq;
> > +       u32 val;
> > +
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > +
> > +       if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
> > +               irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
> > +               if (irq < 0)
> > +                       return irq;
> > +
> > +               doe->irq_name = devm_kasprintf(&doe->doe_dev->adev.dev,
> > +                                               GFP_KERNEL,
> > +                                               "DOE[%s]",
> > +                                               doe->doe_dev->adev.name);
> > +               if (!doe->irq_name)
> > +                       return -ENOMEM;
> > +
> > +               rc = devm_request_irq(&pdev->dev, irq, pci_doe_irq, 0,
> > +                                     doe->irq_name, doe);
> > +               if (rc)
> > +                       return rc;
> > +
> > +               doe->irq = irq;
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> > +                                      PCI_DOE_CTRL_INT_EN);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * pci_doe_probe() - Set up the Mailbox
> > + * @aux_dev: Auxiliary Device
> > + * @id: Auxiliary device ID
> > + *
> > + * Probe the mailbox found for all protocols and set up the Mailbox
> > + *
> > + * RETURNS: 0 on success, < 0 on error
> > + */
> > +static int pci_doe_probe(struct auxiliary_device *aux_dev,
> > +                        const struct auxiliary_device_id *id)
> > +{
> > +       struct pci_doe_dev *doe_dev = container_of(aux_dev,
> > +                                       struct pci_doe_dev,
> > +                                       adev);
> > +       struct pci_doe *doe;
> > +       int rc;
> > +
> > +       doe = devm_kzalloc(&aux_dev->dev, sizeof(*doe), GFP_KERNEL);
> > +       if (!doe)
> > +               return -ENOMEM;
> > +
> > +       mutex_init(&doe->state_lock);
> > +       init_completion(&doe->abort_c);
> > +       doe->doe_dev = doe_dev;
> > +       init_waitqueue_head(&doe->wq);
> > +       INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
> > +       dev_set_drvdata(&aux_dev->dev, doe);
> > +
> > +       rc = pci_doe_reg_irq(doe);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* Reset the mailbox by issuing an abort */
> > +       rc = pci_doe_abort(doe);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc = pci_doe_cache_protocols(doe);
> > +       if (rc)
> > +               return rc;  
> 
> This can just be:
> 
>  return pci_doe_cache_protocols(doe);
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static void pci_doe_remove(struct auxiliary_device *aux_dev)
> > +{
> > +       struct pci_doe *doe = dev_get_drvdata(&aux_dev->dev);
> > +
> > +       /* First halt the state machine */
> > +       cancel_delayed_work_sync(&doe->statemachine);
> > +}
> > +
> > +static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(auxiliary, pci_doe_auxiliary_id_table);  
> 
> Why is this empty table here?
> 
> > +
> > +struct auxiliary_driver pci_doe_auxiliary_drv = {
> > +       .name = "pci_doe",
> > +       .id_table = pci_doe_auxiliary_id_table,
> > +       .probe = pci_doe_probe,
> > +       .remove = pci_doe_remove
> > +};  
> 
> I expect that these helpers would be provided by the PCI core, but
> then a subsystem like CXL would have code to register their auxiliary
> devices and drivers that mostly just wrap the PCI core DOE
> implementation.
> 
> > +
> > +static int __init pci_doe_init_module(void)
> > +{
> > +       int ret;
> > +
> > +       ret = auxiliary_driver_register(&pci_doe_auxiliary_drv);
> > +       if (ret) {
> > +               pr_err("Failed pci_doe auxiliary_driver_register() ret=%d\n",
> > +                      ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void __exit pci_doe_exit_module(void)
> > +{
> > +       auxiliary_driver_unregister(&pci_doe_auxiliary_drv);
> > +}
> > +
> > +module_init(pci_doe_init_module);
> > +module_exit(pci_doe_exit_module);
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > new file mode 100644
> > index 000000000000..2f52b31c6f32
> > --- /dev/null
> > +++ b/include/linux/pci-doe.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Data Object Exchange was added as an ECN to the PCIe r5.0 spec.
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/list.h>
> > +#include <linux/auxiliary_bus.h>
> > +
> > +#ifndef LINUX_PCI_DOE_H
> > +#define LINUX_PCI_DOE_H
> > +
> > +struct pci_doe_protocol {
> > +       u16 vid;
> > +       u8 type;
> > +};
> > +
> > +/**
> > + * struct pci_doe_exchange - represents a single query/response
> > + *
> > + * @prot: DOE Protocol
> > + * @request_pl: The request payload
> > + * @request_pl_sz: Size of the request payload
> > + * @response_pl: The response payload
> > + * @response_pl_sz: Size of the response payload
> > + */
> > +struct pci_doe_exchange {
> > +       struct pci_doe_protocol prot;
> > +       u32 *request_pl;
> > +       size_t request_pl_sz;
> > +       u32 *response_pl;
> > +       size_t response_pl_sz;
> > +};
> > +
> > +/**
> > + * struct pci_doe_dev - DOE mailbox device
> > + *
> > + * @adrv: Auxiliary Driver data
> > + * @pdev: PCI device this belongs to
> > + * @offset: Capability offset
> > + *
> > + * This represents a single DOE mailbox device.  Devices should create this
> > + * device and register it on the Auxiliary bus for the DOE driver to maintain.
> > + *
> > + */
> > +struct pci_doe_dev {
> > +       struct auxiliary_device adev;
> > +       struct pci_dev *pdev;
> > +       int cap_offset;
> > +};
> > +
> > +/* Library operations */
> > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
> > +                                struct pci_doe_exchange *ex);
> > +bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type);
> > +
> > +#endif
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index ff6ccbc6efe9..c04aad391669 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -736,7 +736,8 @@
> >  #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
> >  #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
> >  #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
> > -#define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_PL_16GT
> > +#define PCI_EXT_CAP_ID_DOE     0x2E    /* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_DOE
> >
> >  #define PCI_EXT_CAP_DSN_SIZEOF 12
> >  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > @@ -1098,4 +1099,30 @@
> >  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK                0x000000F0
> >  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT       4
> >
> > +/* Data Object Exchange */
> > +#define PCI_DOE_CAP            0x04    /* DOE Capabilities Register */
> > +#define  PCI_DOE_CAP_INT                       0x00000001  /* Interrupt Support */
> > +#define  PCI_DOE_CAP_IRQ                       0x00000ffe  /* Interrupt Message Number */
> > +#define PCI_DOE_CTRL           0x08    /* DOE Control Register */
> > +#define  PCI_DOE_CTRL_ABORT                    0x00000001  /* DOE Abort */
> > +#define  PCI_DOE_CTRL_INT_EN                   0x00000002  /* DOE Interrupt Enable */
> > +#define  PCI_DOE_CTRL_GO                       0x80000000  /* DOE Go */
> > +#define PCI_DOE_STATUS         0x0c    /* DOE Status Register */
> > +#define  PCI_DOE_STATUS_BUSY                   0x00000001  /* DOE Busy */
> > +#define  PCI_DOE_STATUS_INT_STATUS             0x00000002  /* DOE Interrupt Status */
> > +#define  PCI_DOE_STATUS_ERROR                  0x00000004  /* DOE Error */
> > +#define  PCI_DOE_STATUS_DATA_OBJECT_READY      0x80000000  /* Data Object Ready */
> > +#define PCI_DOE_WRITE          0x10    /* DOE Write Data Mailbox Register */
> > +#define PCI_DOE_READ           0x14    /* DOE Read Data Mailbox Register */
> > +
> > +/* DOE Data Object - note not actually registers */
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID               0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE              0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH            0x0003ffff
> > +
> > +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX           0x000000ff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID             0x0000ffff
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL                0x00ff0000
> > +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX      0xff000000
> > +
> >  #endif /* LINUX_PCI_REGS_H */
> > --
> > 2.31.1
> >  

