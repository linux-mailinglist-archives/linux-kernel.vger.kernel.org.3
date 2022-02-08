Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5514AD162
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347007AbiBHGNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbiBHGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:13:36 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085DC0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:13:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r19so1383181pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 22:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G2FbiPdepqxzWRqr0yQvU8SoE8ldVU79lJNzyc5vgoU=;
        b=L+GvdAF4uG7E4Fo6z/s2QaRkU4dh7cf/pwRGUxPY51zLfAMnsUzpBo/FeRv7+7oC0b
         LCPh4Y4jo1AZ4xchuN396M3OBietQsqlGQqxI6y9tVAXqLCiJ98Kh8MFrcVocqmLdWhH
         MQVKE+8wkX4zEQtxiIlZ3ZrtEjooDJTEWm03o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2FbiPdepqxzWRqr0yQvU8SoE8ldVU79lJNzyc5vgoU=;
        b=kgvfh6xptxNzlQfmdI2tFVE8RVDveGNcRhBrNbeBVyUvKVSTDZL4FwWDYYbWwZhWvm
         LzF6ERqUi0EO9Dk5hM/dw3yEZm4WLjLrJuX58xje1iTE0Q1iQhe4nLQu0NaTh/91wF6M
         ov0Uwd582ib+/9XQJOfZN8Qxx+TKTyQwoLASgMLwwnQN6lgyJxQZMZ1mZymf2v0Sgc7d
         PiKqOvOaoHJj+UumLB9iEiWx5Gb06Ku0wdsASg6d48Db+gWHAd/jkV9HskR8CT1/g4hQ
         DRKpfr/py7D76V7WcwyDOvFs3+jbR4n/ZuLl7DvZAJZrpc4aIl4ZMDspN2APLcmKzfU5
         uuVw==
X-Gm-Message-State: AOAM533mY7jJfB4ZUaxgNacK1ERveV+H6suKg5k1bPMYr16LZ1IN7Y0q
        FwqOpdGCkj1ihkkfJYh6sx/yyw==
X-Google-Smtp-Source: ABdhPJwY5gqPJmWiqrqWyUaAe0ACYh/O+jnyeexZksJPXgP7x/FU4GwTdRVPqyz2sZBNtArLrhRKPg==
X-Received: by 2002:a05:6a00:843:: with SMTP id q3mr3045692pfk.0.1644300815136;
        Mon, 07 Feb 2022 22:13:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm9848925pgh.86.2022.02.07.22.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 22:13:34 -0800 (PST)
Date:   Mon, 7 Feb 2022 22:13:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202202072212.84D10BE535@keescook>
References: <20220125142430.75c3160e@canb.auug.org.au>
 <202201241938.DA2AB1AB4@keescook>
 <20220208154218.14c7d414@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208154218.14c7d414@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:42:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> [Cc'ing the scsi maintainers.  Sorry I should have done that sooner]
> 
> On Mon, 24 Jan 2022 19:43:44 -0800 Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 25, 2022 at 02:24:30PM +1100, Stephen Rothwell wrote:
> > > 
> > > After merging the kspp tree, today's linux-next build (powerpc
> > > allyesconfig) failed like this:
> > > 
> > > 
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_messages':
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
> > >  1934 |                                         crq->valid = VALID_CMD_RESP_EL;
> > >       |                                            ^~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
> > >  1875 |         u64 msg_hi = 0;
> > >       |             ^~~~~~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1935:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
> > >  1935 |                                         crq->format = cmd->rsp.format;
> > >       |                                            ^~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
> > >  1875 |         u64 msg_hi = 0;
> > >       |             ^~~~~~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1938:52: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
> > >  1938 |                                                 crq->status = VIOSRP_ADAPTER_FAIL;
> > >       |                                                    ^~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
> > >  1875 |         u64 msg_hi = 0;
> > >       |             ^~~~~~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1940:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
> > >  1940 |                                         crq->IU_length = cpu_to_be16(cmd->rsp.len);
> > >       |                                            ^~
> > > drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
> > >  1875 |         u64 msg_hi = 0;
> > >       |             ^~~~~~
> > > 
> > > Exposed by commit
> > > 
> > >   4ba545781e20 ("Makefile: Enable -Warray-bounds")
> > > 
> > > Probably introduced by commit
> > > 
> > >   88a678bbc34c ("ibmvscsis: Initial commit of IBM VSCSI Tgt Driver")
> > > 
> > > I applied the following hack for now:
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 25 Jan 2022 14:18:36 +1100
> > > Subject: [PATCH] scsi: hack for building with -Warray-bounds
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> > > index 61f06f6885a5..89fcf98c61c3 100644
> > > --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> > > +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> > > @@ -1872,11 +1872,11 @@ static void srp_snd_msg_failed(struct scsi_info *vscsi, long rc)
> > >   */
> > >  static void ibmvscsis_send_messages(struct scsi_info *vscsi)
> > >  {
> > > -	u64 msg_hi = 0;
> > > +	u64 msg_hi[2] = { };
> > >  	/* note do not attempt to access the IU_data_ptr with this pointer
> > >  	 * it is not valid
> > >  	 */
> > > -	struct viosrp_crq *crq = (struct viosrp_crq *)&msg_hi;
> > > +	struct viosrp_crq *crq = (struct viosrp_crq *)msg_hi;
> > >  	struct ibmvscsis_cmd *cmd, *nxt;
> > >  	long rc = ADAPT_SUCCESS;
> > >  	bool retry = false;
> > > @@ -1940,7 +1940,7 @@ static void ibmvscsis_send_messages(struct scsi_info *vscsi)
> > >  					crq->IU_length = cpu_to_be16(cmd->rsp.len);
> > >  
> > >  					rc = h_send_crq(vscsi->dma_dev->unit_address,
> > > -							be64_to_cpu(msg_hi),
> > > +							be64_to_cpu(msg_hi[0]),
> > >  							be64_to_cpu(cmd->rsp.tag));
> > >  
> > >  					dev_dbg(&vscsi->dev, "send_messages: cmd %p, tag 0x%llx, rc %ld\n",  
> > 
> > This looks correct to me. struct viosrp_crq is 16 bytes wide. The only
> > suggestion I might make would be either avoid the bare '2':
> > 
> > 	u64 msg_hi[sizeof(struct viosrp_crq) / sizeof(u64)] = { };
> > 
> > or adjust struct viosrp_crq so the casting isn't needed at all:
> > 
> > 
> > truct viosrp_crq {
> > 	union {
> > 		u64 hi;
> > 		struct {
> > 		        u8 valid;               /* used by RPA */
> > 		        u8 format;              /* SCSI vs out-of-band */
> > 		        u8 reserved;
> > 		        u8 status;              /* non-scsi failure? (e.g. DMA failure) */
> > 		        __be16 timeout;         /* in seconds */
> > 		        __be16 IU_length;       /* in bytes */
> > 		};
> > 	};
> >         __be64 IU_data_ptr;     /* the TCE for transferring data */
> > };
> > 
> > 	struct viosrp_crq crq = { };
> > 	...
> >  			rc = h_send_crq(vscsi->dma_dev->unit_address,
> > 					be64_to_cpu(crq.hi),
> > 					be64_to_cpu(cmd->rsp.tag));
> > 
> > 
> > 
> 
> Has there been any progress on this?
> 
> Commit 88a678bbc34c mentioned above was merged in v4.8-rc1.

Thanks for the reminder! I've sent this now:

https://lore.kernel.org/lkml/20220208061231.3429486-1-keescook@chromium.org


-- 
Kees Cook
