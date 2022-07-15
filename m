Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF6575DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiGOI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGOI4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:56:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC1656A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:56:07 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F62awI020892;
        Fri, 15 Jul 2022 08:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=o/2fbIF5DfWWYWpeAZ2fUtLGZPItt648pLlllRSgLN0=;
 b=b0WW6yoCfXL3oWijfjE+JCgjk2ymExags+Wef/G1B5BHhSXmYA/Ua2+OnjGhyQcnNgz3
 Jes5F+QJ5VBmH4Nhi/sUBFyVNtg2ibYwyDy2yzZ2pCTDviIB1djiWggxGyB1cffG8Q/Z
 YwTO4AterkK4QLiA1sf1fFNFxd/sWqowmlZemX8h1K/LTg+iKO6ctPqOfuAVsH1pykqr
 2yQxNthUClp7B2woKtEqm2TIOMsnlUo8ajnijJuu0R6KrCsJ0rNm3rX83V7hRAingZOk
 UkA9m6CdSLTx2WsXVmnw5gagpqeXa7ec/oxlqC9BLxVdIyjTSCVekHLegG/X7ZORfQC9 9Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hb2mdhfhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:56:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id A3ECF800190;
        Fri, 15 Jul 2022 08:56:02 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id D64B680329B;
        Fri, 15 Jul 2022 08:56:00 +0000 (UTC)
Date:   Fri, 15 Jul 2022 16:55:57 +0800
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, camille.lu@hpe.com, geoffrey.ndu@hpe.com,
        gustavo.knuppe@hpe.com
Subject: Re: [PATCH v2 1/1] misc: hpilo: switch .{read,write} ops to
 .{read,write}_iter
Message-ID: <20220715085557.GC15061@blofly.os1.tw>
References: <20220713175452.4221-1-matt.hsiao@hpe.com>
 <20220713175452.4221-2-matt.hsiao@hpe.com>
 <Ys8OyLA35o/wr1jB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys8OyLA35o/wr1jB@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: P1YV99jZF9GjxA5ed6veS7gSTn6snTj0
X-Proofpoint-GUID: P1YV99jZF9GjxA5ed6veS7gSTn6snTj0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_03,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207150038
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 08:28:24PM +0200, Greg KH wrote:
> On Thu, Jul 14, 2022 at 01:54:52AM +0800, matt.hsiao@hpe.com wrote:
> > From: Matt Hsiao <matt.hsiao@hpe.com>
> > 
> > Commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel reads and writes
> > without iter ops") requested exclusive .{read,write}_iter ops for
> > kernel_{read,write}. To support dependent drivers to access hpilo by
> > kernel_{read,write}, switch .{read,write} ops to their iter variants.
> > 
> > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> 
> So this fixes a bug?  What commit does this fix?

No, this is not a bug fix. Please see my explanation for your main question below. 

> 
> Should it go to stable branches?  If so, which ones?

No, it does not need to.

> 
> But my main question is I have no idea what the changelog means here.
> What is a "dependent driver"?  What does "exclusive" mean here?  What is
> a iter variant?

There is an out-of-box driver which is not in the upstream kernel yet
that uses kernel_{read,write} to access the hpilo driver for talking
to the iLO ASIC. Before commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel
reads and writes without iter ops"), kernel_{read,write} would call the
.{read,write} file ops that hpilo already implemented, so there was no problem;
But after that commit, kernel_{read,write} would only allow the .{read,write}_iter
file ops, and disallowed the coexistence of .{read,write} file ops. Accessing
hpilo now fails since it does not have the .{read,write}_iter file ops. To make it
work, this patch implements the .{read,write}_iter file ops and removed the
.{read,write} ones.

> 
> 
> 
> > ---
> >  drivers/misc/hpilo.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> > index 8d00df9243c4..5d431a56b7eb 100644
> > --- a/drivers/misc/hpilo.c
> > +++ b/drivers/misc/hpilo.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/poll.h>
> >  #include <linux/slab.h>
> > +#include <linux/uio.h>
> >  #include "hpilo.h"
> >  
> >  static struct class *ilo_class;
> > @@ -435,14 +436,14 @@ static void ilo_set_reset(struct ilo_hwinfo *hw)
> >  	}
> >  }
> >  
> > -static ssize_t ilo_read(struct file *fp, char __user *buf,
> > -			size_t len, loff_t *off)
> > +static ssize_t ilo_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  {
> > -	int err, found, cnt, pkt_id, pkt_len;
> > -	struct ccb_data *data = fp->private_data;
> > +	int err = 0, found, cnt, pkt_id, pkt_len;
> > +	struct ccb_data *data = iocb->ki_filp->private_data;
> >  	struct ccb *driver_ccb = &data->driver_ccb;
> >  	struct ilo_hwinfo *hw = data->ilo_hw;
> >  	void *pkt;
> > +	size_t len = iov_iter_count(to), copied;
> >  
> >  	if (is_channel_reset(driver_ccb)) {
> >  		/*
> > @@ -477,7 +478,9 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
> >  	if (pkt_len < len)
> >  		len = pkt_len;
> >  
> > -	err = copy_to_user(buf, pkt, len);
> > +	copied = copy_to_iter(pkt, len, to);
> > +	if (unlikely(copied != len))
> 
> Why unlikely?  If you can prove it is needed in benchmarks, great,
> otherwise never add likely/unlikely as they are almost always wrong and
> the compiler and cpu can do it better.

Will remove it in the next verion of patch.

> 
> 
> > +		err = -EFAULT;
> >  
> >  	/* return the received packet to the queue */
> >  	ilo_pkt_enqueue(hw, driver_ccb, RECVQ, pkt_id, desc_mem_sz(1));
> > @@ -485,14 +488,14 @@ static ssize_t ilo_read(struct file *fp, char __user *buf,
> >  	return err ? -EFAULT : len;
> >  }
> >  
> > -static ssize_t ilo_write(struct file *fp, const char __user *buf,
> > -			 size_t len, loff_t *off)
> > +static ssize_t ilo_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  {
> > -	int err, pkt_id, pkt_len;
> > -	struct ccb_data *data = fp->private_data;
> > +	int err = 0, pkt_id, pkt_len;
> > +	struct ccb_data *data = iocb->ki_filp->private_data;
> >  	struct ccb *driver_ccb = &data->driver_ccb;
> >  	struct ilo_hwinfo *hw = data->ilo_hw;
> >  	void *pkt;
> > +	size_t len = iov_iter_count(from), copied;
> >  
> >  	if (is_channel_reset(driver_ccb))
> >  		return -ENODEV;
> > @@ -506,9 +509,11 @@ static ssize_t ilo_write(struct file *fp, const char __user *buf,
> >  		len = pkt_len;
> >  
> >  	/* on failure, set the len to 0 to return empty packet to the device */
> > -	err = copy_from_user(pkt, buf, len);
> > -	if (err)
> > +	copied = copy_from_iter(pkt, len, from);
> > +	if (unlikely(copied != len)) {
> 
> Same here.

Will remove it in the next verion of patch.

> 
> thanks,
> 
> greg k-h
