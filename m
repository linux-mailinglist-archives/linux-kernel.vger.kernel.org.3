Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB744B8E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiBPQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:46:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiBPQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C2276D4A;
        Wed, 16 Feb 2022 08:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B097B81F8A;
        Wed, 16 Feb 2022 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB868C004E1;
        Wed, 16 Feb 2022 16:45:46 +0000 (UTC)
Date:   Wed, 16 Feb 2022 22:15:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/25] bus: mhi: Get rid of SHIFT macros and use
 bitfield operations
Message-ID: <20220216164543.GD6225@workstation>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-8-manivannan.sadhasivam@linaro.org>
 <75d684c3-ab7d-2543-bca2-3d8791dd06ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d684c3-ab7d-2543-bca2-3d8791dd06ce@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:02:34PM -0600, Alex Elder wrote:
> On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> > Instead of using the hardcoded SHIFT values, use the bitfield macros to
> > derive the shift value from mask during build time.
> 
> You accomplished this by changing the way mhi_read_reg_field(),
> mhi_poll_reg_field(), and mhi_write_reg_field() are defined.
> It would be helpful for you to point out that fact up front.
> Then it's fairly clear that the _SHIFT (and _SHFT) definitions
> can just go away.  Very nice to remove those though.
> 
> > For shift values that cannot be determined during build time, "__ffs()"
> > helper is used find the shift value in runtime.
> 
> Yeah this is an annoying feature of the bitfield functions,
> but you *know* when you're working with a variable mask.
> 
> I still think the mask values that are 32 bits wide are
> overkill, e.g.:
> 
>   #define MHIREGLEN_MHIREGLEN_MASK	GENMASK(31, 0)
> 
> 
> Thise are full 32-bit registers, and I don't see any reason
> they would ever *not* be full registers, so there's no point
> in applying a mask to them.  Even if some day it did make
> sense to use a mask (less than 32 bits wide, for example),
> that's something that could be added when that becomes an
> issue, rather than complicating the code unnecessarily now.
> 

Okay. Got rid of 32bit masks and modified the commit message.

Thanks,
Mani

> If you eliminate the 32-bit wide masks, great, but even if
> you don't:
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > Suggested-by: Alex Elder <elder@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/common.h        | 45 ----------------------
> >   drivers/bus/mhi/host/boot.c     | 15 ++------
> >   drivers/bus/mhi/host/debugfs.c  | 10 ++---
> >   drivers/bus/mhi/host/init.c     | 67 +++++++++++++++------------------
> >   drivers/bus/mhi/host/internal.h | 10 ++---
> >   drivers/bus/mhi/host/main.c     | 16 ++++----
> >   drivers/bus/mhi/host/pm.c       | 18 +++------
> >   7 files changed, 55 insertions(+), 126 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> > index f226f06d4ff9..728c82928d8d 100644
> > --- a/drivers/bus/mhi/common.h
> > +++ b/drivers/bus/mhi/common.h
> > @@ -63,9 +63,7 @@
> >   /* BHI register bits */
> >   #define BHI_TXDB_SEQNUM_BMSK				GENMASK(29, 0)
> > -#define BHI_TXDB_SEQNUM_SHFT				0
> >   #define BHI_STATUS_MASK					GENMASK(31, 30)
> > -#define BHI_STATUS_SHIFT				30
> >   #define BHI_STATUS_ERROR				0x03
> >   #define BHI_STATUS_SUCCESS				0x02
> >   #define BHI_STATUS_RESET				0x00
> > @@ -85,89 +83,51 @@
> >   /* BHIE register bits */
> >   #define BHIE_TXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
> > -#define BHIE_TXVECDB_SEQNUM_SHFT			0
> >   #define BHIE_TXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
> > -#define BHIE_TXVECSTATUS_SEQNUM_SHFT			0
> >   #define BHIE_TXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
> > -#define BHIE_TXVECSTATUS_STATUS_SHFT			30
> >   #define BHIE_TXVECSTATUS_STATUS_RESET			0x00
> >   #define BHIE_TXVECSTATUS_STATUS_XFER_COMPL		0x02
> >   #define BHIE_TXVECSTATUS_STATUS_ERROR			0x03
> >   #define BHIE_RXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
> > -#define BHIE_RXVECDB_SEQNUM_SHFT			0
> >   #define BHIE_RXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
> > -#define BHIE_RXVECSTATUS_SEQNUM_SHFT			0
> >   #define BHIE_RXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
> > -#define BHIE_RXVECSTATUS_STATUS_SHFT			30
> >   #define BHIE_RXVECSTATUS_STATUS_RESET			0x00
> >   #define BHIE_RXVECSTATUS_STATUS_XFER_COMPL		0x02
> >   #define BHIE_RXVECSTATUS_STATUS_ERROR			0x03
> >   /* MHI register bits */
> >   #define MHIREGLEN_MHIREGLEN_MASK			GENMASK(31, 0)
> > -#define MHIREGLEN_MHIREGLEN_SHIFT			0
> >   #define MHIVER_MHIVER_MASK				GENMASK(31, 0)
> > -#define MHIVER_MHIVER_SHIFT				0
> >   #define MHICFG_NHWER_MASK				GENMASK(31, 24)
> > -#define MHICFG_NHWER_SHIFT				24
> >   #define MHICFG_NER_MASK					GENMASK(23, 16)
> > -#define MHICFG_NER_SHIFT				16
> >   #define MHICFG_NHWCH_MASK				GENMASK(15, 8)
> > -#define MHICFG_NHWCH_SHIFT				8
> >   #define MHICFG_NCH_MASK					GENMASK(7, 0)
> > -#define MHICFG_NCH_SHIFT				0
> >   #define CHDBOFF_CHDBOFF_MASK				GENMASK(31, 0)
> > -#define CHDBOFF_CHDBOFF_SHIFT				0
> >   #define ERDBOFF_ERDBOFF_MASK				GENMASK(31, 0)
> > -#define ERDBOFF_ERDBOFF_SHIFT				0
> >   #define BHIOFF_BHIOFF_MASK				GENMASK(31, 0)
> > -#define BHIOFF_BHIOFF_SHIFT				0
> >   #define BHIEOFF_BHIEOFF_MASK				GENMASK(31, 0)
> > -#define BHIEOFF_BHIEOFF_SHIFT				0
> >   #define DEBUGOFF_DEBUGOFF_MASK				GENMASK(31, 0)
> > -#define DEBUGOFF_DEBUGOFF_SHIFT				0
> >   #define MHICTRL_MHISTATE_MASK				GENMASK(15, 8)
> > -#define MHICTRL_MHISTATE_SHIFT				8
> >   #define MHICTRL_RESET_MASK				BIT(1)
> > -#define MHICTRL_RESET_SHIFT				1
> >   #define MHISTATUS_MHISTATE_MASK				GENMASK(15, 8)
> > -#define MHISTATUS_MHISTATE_SHIFT			8
> >   #define MHISTATUS_SYSERR_MASK				BIT(2)
> > -#define MHISTATUS_SYSERR_SHIFT				2
> >   #define MHISTATUS_READY_MASK				BIT(0)
> > -#define MHISTATUS_READY_SHIFT				0
> >   #define CCABAP_LOWER_CCABAP_LOWER_MASK			GENMASK(31, 0)
> > -#define CCABAP_LOWER_CCABAP_LOWER_SHIFT			0
> >   #define CCABAP_HIGHER_CCABAP_HIGHER_MASK		GENMASK(31, 0)
> > -#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT		0
> >   #define ECABAP_LOWER_ECABAP_LOWER_MASK			GENMASK(31, 0)
> > -#define ECABAP_LOWER_ECABAP_LOWER_SHIFT			0
> >   #define ECABAP_HIGHER_ECABAP_HIGHER_MASK		GENMASK(31, 0)
> > -#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT		0
> >   #define CRCBAP_LOWER_CRCBAP_LOWER_MASK			GENMASK(31, 0)
> > -#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT			0
> >   #define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK		GENMASK(31, 0)
> > -#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT		0
> >   #define CRDB_LOWER_CRDB_LOWER_MASK			GENMASK(31, 0)
> > -#define CRDB_LOWER_CRDB_LOWER_SHIFT			0
> >   #define CRDB_HIGHER_CRDB_HIGHER_MASK			GENMASK(31, 0)
> > -#define CRDB_HIGHER_CRDB_HIGHER_SHIFT			0
> >   #define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK	GENMASK(31, 0)
> > -#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT	0
> >   #define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK	GENMASK(31, 0)
> > -#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT	0
> >   #define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK	GENMASK(31, 0)
> > -#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT	0
> >   #define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK	GENMASK(31, 0)
> > -#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT	0
> >   #define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK	GENMASK(31, 0)
> > -#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT	0
> >   #define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK	GENMASK(31, 0)
> > -#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT	0
> >   #define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK	GENMASK(31, 0)
> > -#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT	0
> >   #define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK	GENMASK(31, 0)
> > -#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT	0
> >   /* Command Ring Element macros */
> >   /* No operation command */
> > @@ -277,9 +237,7 @@ enum mhi_cmd_type {
> >   #define EV_CTX_RESERVED_MASK GENMASK(7, 0)
> >   #define EV_CTX_INTMODC_MASK GENMASK(15, 8)
> > -#define EV_CTX_INTMODC_SHIFT 8
> >   #define EV_CTX_INTMODT_MASK GENMASK(31, 16)
> > -#define EV_CTX_INTMODT_SHIFT 16
> >   struct mhi_event_ctxt {
> >   	__le32 intmod;
> >   	__le32 ertype;
> > @@ -292,11 +250,8 @@ struct mhi_event_ctxt {
> >   };
> >   #define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
> > -#define CHAN_CTX_CHSTATE_SHIFT 0
> >   #define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
> > -#define CHAN_CTX_BRSTMODE_SHIFT 8
> >   #define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
> > -#define CHAN_CTX_POLLCFG_SHIFT 10
> >   #define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
> >   struct mhi_chan_ctxt {
> >   	__le32 chcfg;
> > diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> > index 93cb705614c6..b0da7ca4519c 100644
> > --- a/drivers/bus/mhi/host/boot.c
> > +++ b/drivers/bus/mhi/host/boot.c
> > @@ -46,8 +46,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
> >   	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
> >   	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
> > -			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
> > -			    sequence_id);
> > +			    BHIE_RXVECDB_SEQNUM_BMSK, sequence_id);
> >   	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
> >   		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
> > @@ -127,9 +126,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
> >   	while (retry--) {
> >   		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
> > -					 BHIE_RXVECSTATUS_STATUS_BMSK,
> > -					 BHIE_RXVECSTATUS_STATUS_SHFT,
> > -					 &rx_status);
> > +					 BHIE_RXVECSTATUS_STATUS_BMSK, &rx_status);
> >   		if (ret)
> >   			return -EIO;
> > @@ -168,7 +165,6 @@ int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
> >   			   mhi_read_reg_field(mhi_cntrl, base,
> >   					      BHIE_RXVECSTATUS_OFFS,
> >   					      BHIE_RXVECSTATUS_STATUS_BMSK,
> > -					      BHIE_RXVECSTATUS_STATUS_SHFT,
> >   					      &rx_status) || rx_status,
> >   			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> > @@ -203,8 +199,7 @@ static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
> >   	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
> >   	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
> > -			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
> > -			    sequence_id);
> > +			    BHIE_TXVECDB_SEQNUM_BMSK, sequence_id);
> >   	read_unlock_bh(pm_lock);
> >   	/* Wait for the image download to complete */
> > @@ -213,7 +208,6 @@ static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
> >   				 mhi_read_reg_field(mhi_cntrl, base,
> >   						   BHIE_TXVECSTATUS_OFFS,
> >   						   BHIE_TXVECSTATUS_STATUS_BMSK,
> > -						   BHIE_TXVECSTATUS_STATUS_SHFT,
> >   						   &tx_status) || tx_status,
> >   				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
> >   	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> > @@ -265,8 +259,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
> >   	ret = wait_event_timeout(mhi_cntrl->state_event,
> >   			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> >   			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
> > -					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
> > -					      &tx_status) || tx_status,
> > +					      BHI_STATUS_MASK, &tx_status) || tx_status,
> >   			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
> >   	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
> >   		goto invalid_pm_state;
> > diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
> > index 399d0db1f1eb..cfec7811dfbb 100644
> > --- a/drivers/bus/mhi/host/debugfs.c
> > +++ b/drivers/bus/mhi/host/debugfs.c
> > @@ -61,9 +61,9 @@ static int mhi_debugfs_events_show(struct seq_file *m, void *d)
> >   		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
> >   			   i, (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODC_MASK) >>
> > -			   EV_CTX_INTMODC_SHIFT,
> > +			   __ffs(EV_CTX_INTMODC_MASK),
> >   			   (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODT_MASK) >>
> > -			   EV_CTX_INTMODT_SHIFT);
> > +			   __ffs(EV_CTX_INTMODT_MASK));
> >   		seq_printf(m, " base: 0x%0llx len: 0x%llx", le64_to_cpu(er_ctxt->rbase),
> >   			   le64_to_cpu(er_ctxt->rlen));
> > @@ -107,10 +107,10 @@ static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
> >   		seq_printf(m,
> >   			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
> >   			   mhi_chan->name, mhi_chan->chan, (le32_to_cpu(chan_ctxt->chcfg) &
> > -			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
> > +			   CHAN_CTX_CHSTATE_MASK) >> __ffs(CHAN_CTX_CHSTATE_MASK),
> >   			   (le32_to_cpu(chan_ctxt->chcfg) & CHAN_CTX_BRSTMODE_MASK) >>
> > -			   CHAN_CTX_BRSTMODE_SHIFT, (le32_to_cpu(chan_ctxt->chcfg) &
> > -			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
> > +			   __ffs(CHAN_CTX_BRSTMODE_MASK), (le32_to_cpu(chan_ctxt->chcfg) &
> > +			   CHAN_CTX_POLLCFG_MASK) >> __ffs(CHAN_CTX_POLLCFG_MASK));
> >   		seq_printf(m, " type: 0x%x event ring: %u", le32_to_cpu(chan_ctxt->chtype),
> >   			   le32_to_cpu(chan_ctxt->erindex));
> > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > index 0e301f3f305e..05e457d12446 100644
> > --- a/drivers/bus/mhi/host/init.c
> > +++ b/drivers/bus/mhi/host/init.c
> > @@ -4,6 +4,7 @@
> >    *
> >    */
> > +#include <linux/bitfield.h>
> >   #include <linux/debugfs.h>
> >   #include <linux/device.h>
> >   #include <linux/dma-direction.h>
> > @@ -283,11 +284,11 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
> >   		tmp = le32_to_cpu(chan_ctxt->chcfg);
> >   		tmp &= ~CHAN_CTX_CHSTATE_MASK;
> > -		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
> > +		tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_DISABLED);
> >   		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
> > -		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
> > +		tmp |= FIELD_PREP(CHAN_CTX_BRSTMODE_MASK, mhi_chan->db_cfg.brstmode);
> >   		tmp &= ~CHAN_CTX_POLLCFG_MASK;
> > -		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
> > +		tmp |= FIELD_PREP(CHAN_CTX_POLLCFG_MASK, mhi_chan->db_cfg.pollcfg);
> >   		chan_ctxt->chcfg = cpu_to_le32(tmp);
> >   		chan_ctxt->chtype = cpu_to_le32(mhi_chan->type);
> > @@ -319,7 +320,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
> >   		tmp = le32_to_cpu(er_ctxt->intmod);
> >   		tmp &= ~EV_CTX_INTMODC_MASK;
> >   		tmp &= ~EV_CTX_INTMODT_MASK;
> > -		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
> > +		tmp |= FIELD_PREP(EV_CTX_INTMODT_MASK, mhi_event->intmod);
> >   		er_ctxt->intmod = cpu_to_le32(tmp);
> >   		er_ctxt->ertype = cpu_to_le32(MHI_ER_TYPE_VALID);
> > @@ -425,71 +426,70 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> >   	struct {
> >   		u32 offset;
> >   		u32 mask;
> > -		u32 shift;
> >   		u32 val;
> >   	} reg_info[] = {
> >   		{
> > -			CCABAP_HIGHER, U32_MAX, 0,
> > +			CCABAP_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
> >   		},
> >   		{
> > -			CCABAP_LOWER, U32_MAX, 0,
> > +			CCABAP_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
> >   		},
> >   		{
> > -			ECABAP_HIGHER, U32_MAX, 0,
> > +			ECABAP_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
> >   		},
> >   		{
> > -			ECABAP_LOWER, U32_MAX, 0,
> > +			ECABAP_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
> >   		},
> >   		{
> > -			CRCBAP_HIGHER, U32_MAX, 0,
> > +			CRCBAP_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
> >   		},
> >   		{
> > -			CRCBAP_LOWER, U32_MAX, 0,
> > +			CRCBAP_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
> >   		},
> >   		{
> > -			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
> > +			MHICFG, MHICFG_NER_MASK,
> >   			mhi_cntrl->total_ev_rings,
> >   		},
> >   		{
> > -			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
> > +			MHICFG, MHICFG_NHWER_MASK,
> >   			mhi_cntrl->hw_ev_rings,
> >   		},
> >   		{
> > -			MHICTRLBASE_HIGHER, U32_MAX, 0,
> > +			MHICTRLBASE_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->iova_start),
> >   		},
> >   		{
> > -			MHICTRLBASE_LOWER, U32_MAX, 0,
> > +			MHICTRLBASE_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->iova_start),
> >   		},
> >   		{
> > -			MHIDATABASE_HIGHER, U32_MAX, 0,
> > +			MHIDATABASE_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->iova_start),
> >   		},
> >   		{
> > -			MHIDATABASE_LOWER, U32_MAX, 0,
> > +			MHIDATABASE_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->iova_start),
> >   		},
> >   		{
> > -			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
> > +			MHICTRLLIMIT_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->iova_stop),
> >   		},
> >   		{
> > -			MHICTRLLIMIT_LOWER, U32_MAX, 0,
> > +			MHICTRLLIMIT_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->iova_stop),
> >   		},
> >   		{
> > -			MHIDATALIMIT_HIGHER, U32_MAX, 0,
> > +			MHIDATALIMIT_HIGHER, U32_MAX,
> >   			upper_32_bits(mhi_cntrl->iova_stop),
> >   		},
> >   		{
> > -			MHIDATALIMIT_LOWER, U32_MAX, 0,
> > +			MHIDATALIMIT_LOWER, U32_MAX,
> >   			lower_32_bits(mhi_cntrl->iova_stop),
> >   		},
> >   		{ 0, 0, 0 }
> > @@ -498,8 +498,7 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> >   	dev_dbg(dev, "Initializing MHI registers\n");
> >   	/* Read channel db offset */
> > -	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
> > -				 CHDBOFF_CHDBOFF_SHIFT, &val);
> > +	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK, &val);
> >   	if (ret) {
> >   		dev_err(dev, "Unable to read CHDBOFF register\n");
> >   		return -EIO;
> > @@ -515,8 +514,7 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> >   		mhi_chan->tre_ring.db_addr = base + val;
> >   	/* Read event ring db offset */
> > -	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
> > -				 ERDBOFF_ERDBOFF_SHIFT, &val);
> > +	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK, &val);
> >   	if (ret) {
> >   		dev_err(dev, "Unable to read ERDBOFF register\n");
> >   		return -EIO;
> > @@ -537,8 +535,7 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> >   	/* Write to MMIO registers */
> >   	for (i = 0; reg_info[i].offset; i++)
> >   		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
> > -				    reg_info[i].mask, reg_info[i].shift,
> > -				    reg_info[i].val);
> > +				    reg_info[i].mask, reg_info[i].val);
> >   	return 0;
> >   }
> > @@ -571,7 +568,7 @@ void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
> >   	tmp = le32_to_cpu(chan_ctxt->chcfg);
> >   	tmp &= ~CHAN_CTX_CHSTATE_MASK;
> > -	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
> > +	tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_DISABLED);
> >   	chan_ctxt->chcfg = cpu_to_le32(tmp);
> >   	/* Update to all cores */
> > @@ -608,7 +605,7 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
> >   	tmp = le32_to_cpu(chan_ctxt->chcfg);
> >   	tmp &= ~CHAN_CTX_CHSTATE_MASK;
> > -	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
> > +	tmp |= FIELD_PREP(CHAN_CTX_CHSTATE_MASK, MHI_CH_STATE_ENABLED);
> >   	chan_ctxt->chcfg = cpu_to_le32(tmp);
> >   	chan_ctxt->rbase = cpu_to_le64(tre_ring->iommu_base);
> > @@ -952,14 +949,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
> >   	if (ret)
> >   		goto err_destroy_wq;
> > -	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
> > -					SOC_HW_VERSION_FAM_NUM_SHFT;
> > -	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
> > -					SOC_HW_VERSION_DEV_NUM_SHFT;
> > -	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
> > -					SOC_HW_VERSION_MAJOR_VER_SHFT;
> > -	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
> > -					SOC_HW_VERSION_MINOR_VER_SHFT;
> > +	mhi_cntrl->family_number = FIELD_GET(SOC_HW_VERSION_FAM_NUM_BMSK, soc_info);
> > +	mhi_cntrl->device_number = FIELD_GET(SOC_HW_VERSION_DEV_NUM_BMSK, soc_info);
> > +	mhi_cntrl->major_version = FIELD_GET(SOC_HW_VERSION_MAJOR_VER_BMSK, soc_info);
> > +	mhi_cntrl->minor_version = FIELD_GET(SOC_HW_VERSION_MINOR_VER_BMSK, soc_info);
> >   	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
> >   	if (mhi_cntrl->index < 0) {
> > diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> > index 762055a6ec9f..21381781d7c5 100644
> > --- a/drivers/bus/mhi/host/internal.h
> > +++ b/drivers/bus/mhi/host/internal.h
> > @@ -82,13 +82,9 @@ extern struct bus_type mhi_bus_type;
> >   #define SOC_HW_VERSION_OFFS		0x224
> >   #define SOC_HW_VERSION_FAM_NUM_BMSK	GENMASK(31, 28)
> > -#define SOC_HW_VERSION_FAM_NUM_SHFT	28
> >   #define SOC_HW_VERSION_DEV_NUM_BMSK	GENMASK(27, 16)
> > -#define SOC_HW_VERSION_DEV_NUM_SHFT	16
> >   #define SOC_HW_VERSION_MAJOR_VER_BMSK	GENMASK(15, 8)
> > -#define SOC_HW_VERSION_MAJOR_VER_SHFT	8
> >   #define SOC_HW_VERSION_MINOR_VER_BMSK	GENMASK(7, 0)
> > -#define SOC_HW_VERSION_MINOR_VER_SHFT	0
> >   struct mhi_ctxt {
> >   	struct mhi_event_ctxt *er_ctxt;
> > @@ -393,14 +389,14 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
> >   			      void __iomem *base, u32 offset, u32 *out);
> >   int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
> >   				    void __iomem *base, u32 offset, u32 mask,
> > -				    u32 shift, u32 *out);
> > +				    u32 *out);
> >   int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
> >   				    void __iomem *base, u32 offset, u32 mask,
> > -				    u32 shift, u32 val, u32 delayus);
> > +				    u32 val, u32 delayus);
> >   void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
> >   		   u32 offset, u32 val);
> >   void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> > -			 u32 offset, u32 mask, u32 shift, u32 val);
> > +			 u32 offset, u32 mask, u32 val);
> >   void mhi_ring_er_db(struct mhi_event *mhi_event);
> >   void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
> >   		  dma_addr_t db_val);
> > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > index e436c2993d97..02ac5faf9178 100644
> > --- a/drivers/bus/mhi/host/main.c
> > +++ b/drivers/bus/mhi/host/main.c
> > @@ -24,7 +24,7 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
> >   int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
> >   				    void __iomem *base, u32 offset,
> > -				    u32 mask, u32 shift, u32 *out)
> > +				    u32 mask, u32 *out)
> >   {
> >   	u32 tmp;
> >   	int ret;
> > @@ -33,21 +33,20 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
> >   	if (ret)
> >   		return ret;
> > -	*out = (tmp & mask) >> shift;
> > +	*out = (tmp & mask) >> __ffs(mask);
> >   	return 0;
> >   }
> >   int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
> >   				    void __iomem *base, u32 offset,
> > -				    u32 mask, u32 shift, u32 val, u32 delayus)
> > +				    u32 mask, u32 val, u32 delayus)
> >   {
> >   	int ret;
> >   	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
> >   	while (retry--) {
> > -		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, shift,
> > -					 &out);
> > +		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, &out);
> >   		if (ret)
> >   			return ret;
> > @@ -67,7 +66,7 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
> >   }
> >   void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> > -			 u32 offset, u32 mask, u32 shift, u32 val)
> > +			 u32 offset, u32 mask, u32 val)
> >   {
> >   	int ret;
> >   	u32 tmp;
> > @@ -77,7 +76,7 @@ void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> >   		return;
> >   	tmp &= ~mask;
> > -	tmp |= (val << shift);
> > +	tmp |= (val << __ffs(mask));
> >   	mhi_write_reg(mhi_cntrl, base, offset, tmp);
> >   }
> > @@ -159,8 +158,7 @@ enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
> >   {
> >   	u32 state;
> >   	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
> > -				     MHISTATUS_MHISTATE_MASK,
> > -				     MHISTATUS_MHISTATE_SHIFT, &state);
> > +				     MHISTATUS_MHISTATE_MASK, &state);
> >   	return ret ? MHI_STATE_MAX : state;
> >   }
> >   EXPORT_SYMBOL_GPL(mhi_get_mhi_state);
> > diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> > index 088ade0f3e0b..3d90b8ecd3d9 100644
> > --- a/drivers/bus/mhi/host/pm.c
> > +++ b/drivers/bus/mhi/host/pm.c
> > @@ -131,11 +131,10 @@ void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
> >   {
> >   	if (state == MHI_STATE_RESET) {
> >   		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> > -				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
> > +				    MHICTRL_RESET_MASK, 1);
> >   	} else {
> >   		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> > -				    MHICTRL_MHISTATE_MASK,
> > -				    MHICTRL_MHISTATE_SHIFT, state);
> > +				    MHICTRL_MHISTATE_MASK, state);
> >   	}
> >   }
> > @@ -167,16 +166,14 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
> >   	/* Wait for RESET to be cleared and READY bit to be set by the device */
> >   	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> > -				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
> > -				 interval_us);
> > +				 MHICTRL_RESET_MASK, 0, interval_us);
> >   	if (ret) {
> >   		dev_err(dev, "Device failed to clear MHI Reset\n");
> >   		return ret;
> >   	}
> >   	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
> > -				 MHISTATUS_READY_MASK, MHISTATUS_READY_SHIFT, 1,
> > -				 interval_us);
> > +				 MHISTATUS_READY_MASK, 1, interval_us);
> >   	if (ret) {
> >   		dev_err(dev, "Device failed to enter MHI Ready\n");
> >   		return ret;
> > @@ -470,8 +467,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
> >   		/* Wait for the reset bit to be cleared by the device */
> >   		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> > -				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
> > -				 25000);
> > +				 MHICTRL_RESET_MASK, 0, 25000);
> >   		if (ret)
> >   			dev_err(dev, "Device failed to clear MHI Reset\n");
> > @@ -602,7 +598,6 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
> >   							    mhi_cntrl->regs,
> >   							    MHICTRL,
> >   							    MHICTRL_RESET_MASK,
> > -							    MHICTRL_RESET_SHIFT,
> >   							    &in_reset) ||
> >   					!in_reset, timeout);
> >   		if (!ret || in_reset) {
> > @@ -1093,8 +1088,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
> >   	if (state == MHI_STATE_SYS_ERR) {
> >   		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
> >   		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
> > -				 MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 0,
> > -				 interval_us);
> > +				 MHICTRL_RESET_MASK, 0, interval_us);
> >   		if (ret) {
> >   			dev_info(dev, "Failed to reset MHI due to syserr state\n");
> >   			goto error_exit;
> 
