Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D24BBC07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiBRPXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:23:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiBRPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:23:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494DD245FCF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:23:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 12so4600670pgd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RwCcFdhA/X2hruOoYkWLaIBS5U88ujPQ6qoruVa+ww=;
        b=kYDSy2oPVtmkUpRBoTpgiDfZGQd8pERYWmKHa9YhnsxXjVNRVd4Qa621kcvdrTBIrB
         NfxlxfRe0OfguCokh+C5kJT1/CEFHHC3nBT2OF5MQ3VJY8Kpw7r135x7dFuHs6HoL7wo
         6t1zTplnKxFMIj27ry13PgD35XrcNnsSf/xXy6QlyjHsWJ/7hc8nuKNzw8eo4CsS2ES3
         IIXajxiJkEmkLroI/Jt3s7NbolSkW+qKa8UrH5j7m7Nqk0ej5uG+hDhPzn/bmOcC+TPS
         dGgCFUaPiAsrhrFmxIi8PeyOCw0cEtuFMWMMD2AyAjcss5owSvWOFI4qVRurB8d6bQfz
         Jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RwCcFdhA/X2hruOoYkWLaIBS5U88ujPQ6qoruVa+ww=;
        b=bsMHdIlAOUHKF2rBzz3S+UynaGaf0YvijaDha+oi4CJfJop2A1HGXK80YSCAmhVC6u
         cZC7sXqNMPORd/M1PaeeN97SdJZPIyPyQPSGy+dLDbB44+ngqJY1OCAIH1Z+WZaVIc9P
         ML3m7fjfuobJGNmzowy3iJMg1scOAnSA3QfUU9VS41i2We/S/QU7N3jPLscBLPG+thl7
         zgT4UemdGgintE0ts0RE66mnYFe31rGwgniNFz2BUi+RmYVKc3OQcoU4EIeR7GfHKK9x
         YhlIqyNg0TWD0PrUh1IBA653UCL1Ev8wprEpBEhHuZCMtMyrR/SNMFHGWdqYv2XGIKE9
         pYdA==
X-Gm-Message-State: AOAM533NyIdd8Hv3w5gbY3m2U/gCmM7cAaetr+yAdqrqU/PtNNZ+KAWT
        ewNqkS8Gx+QDzz1yGq4vRnQi
X-Google-Smtp-Source: ABdhPJwfefVGgDsHN9UERxO8rdUU6jkFkjkaNjix07IvX1cbp2DR3CrwKHKSgMtqskkl1e7h2s+4bg==
X-Received: by 2002:a05:6a00:1d8a:b0:4e1:559d:2f62 with SMTP id z10-20020a056a001d8a00b004e1559d2f62mr8231278pfw.26.1645197815650;
        Fri, 18 Feb 2022 07:23:35 -0800 (PST)
Received: from thinkpad ([220.158.158.204])
        by smtp.gmail.com with ESMTPSA id g12sm3327793pfm.119.2022.02.18.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:23:35 -0800 (PST)
Date:   Fri, 18 Feb 2022 20:53:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/25] bus: mhi: ep: Add support for ring management
Message-ID: <20220218152327.GA11639@thinkpad>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-13-manivannan.sadhasivam@linaro.org>
 <20504c14-6df5-83d1-53e9-85c682a5a3c7@linaro.org>
 <20220218080704.GD11964@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218080704.GD11964@workstation>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:37:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 02:03:13PM -0600, Alex Elder wrote:
> > On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> > > Add support for managing the MHI ring. The MHI ring is a circular queue
> > > of data structures used to pass the information between host and the
> > > endpoint.
> > > 
> > > MHI support 3 types of rings:
> > > 
> > > 1. Transfer ring
> > > 2. Event ring
> > > 3. Command ring
> > > 
> > > All rings reside inside the host memory and the MHI EP device maps it to
> > > the device memory using blocks like PCIe iATU. The mapping is handled in
> > > the MHI EP controller driver itself.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Great explanation.  One more thing to add, is that the command
> > and transfer rings are directed from the host to the MHI EP device,
> > while the event rings are directed from the EP device toward the
> > host.
> > 
> 
> That's correct, will add.
> 
> > I notice that you've improved a few things I had notes about,
> > and I don't recall suggesting them.  I'm very happy about that.
> > 
> > I have a few more comments here, some worth thinking about
> > at least.
> > 
> > 					-Alex
> > 
> > > ---
> > >   drivers/bus/mhi/ep/Makefile   |   2 +-
> > >   drivers/bus/mhi/ep/internal.h |  33 +++++
> > >   drivers/bus/mhi/ep/main.c     |  59 +++++++-
> > >   drivers/bus/mhi/ep/ring.c     | 267 ++++++++++++++++++++++++++++++++++
> > >   include/linux/mhi_ep.h        |  11 ++
> > >   5 files changed, 370 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/bus/mhi/ep/ring.c
> > > 
> > > diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> > > index a1555ae287ad..7ba0e04801eb 100644
> > > --- a/drivers/bus/mhi/ep/Makefile
> > > +++ b/drivers/bus/mhi/ep/Makefile
> > > @@ -1,2 +1,2 @@
> > >   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> > > -mhi_ep-y := main.o mmio.o
> > > +mhi_ep-y := main.o mmio.o ring.o
> > > diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> > > index 2c756a90774c..48d6e9667d55 100644
> > > --- a/drivers/bus/mhi/ep/internal.h
> > > +++ b/drivers/bus/mhi/ep/internal.h
> > > @@ -112,6 +112,18 @@ enum mhi_ep_execenv {
> > >   	MHI_EP_UNRESERVED
> > >   };
> > > +/* Transfer Ring Element macros */
> > > +#define MHI_EP_TRE_PTR(ptr) (ptr)
> > > +#define MHI_EP_TRE_DWORD0(len) (len & MHI_MAX_MTU)
> > 
> > The above looks funny.  This assumes MHI_MAX_MTU is
> > a mask value (likely one less than a power-of-2).
> > That doesn't seem obvious to me; use modulo if you
> > must, but better, just ensure len is in range rather
> > than silently truncating it if it's not.
> > 
> > > +#define MHI_EP_TRE_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> > > +	| (ieot << 9) | (ieob << 8) | chain)
> > 
> > You should probably use FIELD_PREP() to compute the value
> > here, since you're using FIELD_GET() to extract the field
> > values below.
> > 
> > > +#define MHI_EP_TRE_GET_PTR(tre) ((tre)->ptr)
> > > +#define MHI_EP_TRE_GET_LEN(tre) ((tre)->dword[0] & 0xffff)
> > > +#define MHI_EP_TRE_GET_CHAIN(tre) FIELD_GET(BIT(0), (tre)->dword[1])
> > 
> > #define	TRE_FLAG_CHAIN	BIT(0)
> > 
> > Then just call
> > 	bei = FIELD_GET(TRE_FLAG_CHAIN, tre->dword[1]);
> > 
> > But I haven't looked at the code where this is used yet.
> > 
> > > +#define MHI_EP_TRE_GET_IEOB(tre) FIELD_GET(BIT(8), (tre)->dword[1])
> > > +#define MHI_EP_TRE_GET_IEOT(tre) FIELD_GET(BIT(9), (tre)->dword[1])
> > > +#define MHI_EP_TRE_GET_BEI(tre) FIELD_GET(BIT(10), (tre)->dword[1])
> > > +
> > 
> > These macros should be shared/shareable between the host and endpoint.
> > They operate on external interfaces and so should be byte swapped
> > (where used) when updating actual memory.  Unlike the patches from
> > Paul Davey early in this series, this does *not* byte swap the
> > values in the right hand side of these definitions, which is good.
> > 
> > I'm pretty sure I mentioned this before...  I don't really like these
> > "DWORD" macros that simply write compute register values to write
> > out to the TREs.  A TRE is a structure, not a set of registers.  And
> > a whole TRE can be written or read in a single ARM instruction in
> > some cases--but most likely you need to define it as a structure
> > for that to happen.
> > 
> > struct mhi_tre {
> > 	__le64 addr;
> > 	__le16 len_opcode
> > 	__le16 reserved;
> > 	__le32 flags;
> > };
> 
> Changing the TRE structure requires changes to both host and endpoint
> stack. So I'll tackle this as an improvement later.
> 
> Added to TODO list.

Just did a comparision w/ IPA code and I convinced myself that this conversion
should happen now itself. So please ignore my above comment.

Thanks,
Mani

> 
> > 
> > Which reminds me, this shared memory area should probably be mapped
> > using memremap() rather than ioremap().  I haven't checked whether
> > it is...
> > 
> > >   enum mhi_ep_ring_type {
> > >   	RING_TYPE_CMD = 0,
> > >   	RING_TYPE_ER,
> > > @@ -131,6 +143,11 @@ union mhi_ep_ring_ctx {
> > >   	struct mhi_generic_ctx generic;
> > >   };
> > > +struct mhi_ep_ring_item {
> > > +	struct list_head node;
> > > +	struct mhi_ep_ring *ring;
> > > +};
> > > +
> > >   struct mhi_ep_ring {
> > >   	struct mhi_ep_cntrl *mhi_cntrl;
> > >   	int (*ring_cb)(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> > > @@ -143,6 +160,9 @@ struct mhi_ep_ring {
> > >   	u32 db_offset_h;
> > >   	u32 db_offset_l;
> > >   	u32 ch_id;
> > > +	u32 er_index;
> > > +	u32 irq_vector;
> > > +	bool started;
> > >   };
> > >   struct mhi_ep_cmd {
> > > @@ -168,6 +188,19 @@ struct mhi_ep_chan {
> > >   	bool skip_td;
> > >   };
> > > +/* MHI Ring related functions */
> > > +void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
> > > +void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
> > > +int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> > > +		      union mhi_ep_ring_ctx *ctx);
> > > +size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
> > > +int mhi_ep_process_ring(struct mhi_ep_ring *ring);
> > > +int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element);
> > > +void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
> > > +int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> > > +int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el);
> > > +int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring);
> > > +
> > >   /* MMIO related functions */
> > >   u32 mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset);
> > >   void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> > > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > > index 950b5bcabe18..2c8045766292 100644
> > > --- a/drivers/bus/mhi/ep/main.c
> > > +++ b/drivers/bus/mhi/ep/main.c
> > > @@ -18,6 +18,48 @@
> > >   static DEFINE_IDA(mhi_ep_cntrl_ida);
> > 
> > The following function handles command or channel interrupt work.
> > 
> 
> Both
> 
> > > +static void mhi_ep_ring_worker(struct work_struct *work)
> > > +{
> > > +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
> > > +				struct mhi_ep_cntrl, ring_work);
> > > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > > +	struct mhi_ep_ring_item *itr, *tmp;
> > > +	struct mhi_ep_ring *ring;
> > > +	struct mhi_ep_chan *chan;
> > > +	unsigned long flags;
> > > +	LIST_HEAD(head);
> > > +	int ret;
> > > +
> > > +	/* Process the command ring first */
> > > +	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
> > > +	if (ret) {
> > 
> > At the moment I'm not sure where this work gets scheduled.
> > But what if there is no command to process?  It looks
> > like you go update the cached pointer no matter what
> > to see if there's anything new.  But it seems like you
> > ought to be able to do this when interrupted for a
> > command rather than all the time.
> > 
> 
> No, ring cache is not getting updated all the time. If you look into
> process_ring(), first the write pointer is read from MMIO and there is a
> check to see if there are elements in the ring or not. Only if that
> check passes, the ring cache will get updated.
> 
> Since the same work item is used for both cmd and transfer rings, this
> check is necessary. The other option would be to use different work items
> for command and transfer rings. This is something I want to try once
> this initial version gets merged.
> 
> Thanks,
> Mani
