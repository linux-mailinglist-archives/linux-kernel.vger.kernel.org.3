Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BF571CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiGLOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiGLOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:36:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC5BA386
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:36:42 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CDC7r7012013;
        Tue, 12 Jul 2022 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=790MkQcJxYna5ILBe0ZbAjCXOj4DIU0QiKAhG//8tVw=;
 b=aeqgb+XZfG1MnjuyA4ncTulK3VXmKb0zzvdJrkpIu8V19cl/MBZDB838hlgMF5u2CRUG
 2gVARetwi/1Z/iBl+U7oDYzUKOk9Pdfsl33LX4OXYzg43r+rYyVm8yz/hzBywB/3m5lA
 bsidBH1WSaePjmhvvIn09sYtlgYvTA889z4pMcG54XfrQJ97n0rxQfSHXBwoOK9tFwK2
 oN57z/LmmD0LZWSwfQCCnjN1isRvsqf9rnDHBtGEsR2blQtEsL09ioLB6VK0vUUyxBMH
 oy+yxylhbO963aPh9B/ur0trapXELbnTkUnlwXAb+jb5pVbRORq2tsslCuB1lwBh6+9X zw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h98jvm5ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 14:36:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CEZulG007859;
        Tue, 12 Jul 2022 14:36:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3h8ncngds1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 14:36:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CEYxHw23724416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:34:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A303CA405B;
        Tue, 12 Jul 2022 14:36:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A00A4054;
        Tue, 12 Jul 2022 14:36:28 +0000 (GMT)
Received: from sig-9-145-145-217.de.ibm.com (unknown [9.145.145.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 14:36:28 +0000 (GMT)
Message-ID: <ff46adb9be9df70f6906e86c5e9220adf50842fd.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the
 PCI device is isolated
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Stefan Roese <sr@denx.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 16:36:27 +0200
In-Reply-To: <Ys2CeIqv//5ZGJTM@kbusch-mbp>
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
         <20220712124453.2227362-2-schnelle@linux.ibm.com>
         <Ys2CeIqv//5ZGJTM@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 08SCBWmOnqCeDLIk72GnqSbgz8WUgCCw
X-Proofpoint-ORIG-GUID: 08SCBWmOnqCeDLIk72GnqSbgz8WUgCCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-12 at 08:17 -0600, Keith Busch wrote:
> On Tue, Jul 12, 2022 at 02:44:53PM +0200, Niklas Schnelle wrote:
> > On s390 and powerpc PCI devices are isolated when an error is detected
> > and driver->err_handler->error_detected is called with an inaccessible
> > PCI device and PCI channel state set to pci_channel_io_frozen
> > (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
> > 
> > In the case of NVMe devices nvme_error_detected() then calls
> > nvme_dev_disable(dev, false) and requests a reset. After a successful
> > reset the device is accessible again and nvme_slot_reset() resets the
> > controller and queues nvme_reset_work() which then recovers the
> > controller.
> > 
> > Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
> > nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
> > queues if pci_device_is_present() returns false. This is the case for an
> > isolated PCI device. In principle this makes sense as there are no
> > accessible hardware queues to run. The problem though is that for
> > a previously live reset controller with online queues nvme_reset_work()
> > calls nvme_wait_freeze() which, without the freeze having been
> > initiated, then hangs forever. Fix this by starting the freeze in
> > nvme_slot_reset() which is the earliest point where we know the device
> > should be accessible again.
> > 
> > Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Oh, we've messed up the expected sequence. The mistaken assumption is a device
> not present means we're about to unbind from it, but it could appear that way
> just for normal error handling and reset, so we need to preserve the previous
> handling.
> 
> The offending commit really just wants to avoid the register access (which we
> shouldn't have to do, but hey, broken hardware...). So let's keep the sequence
> the same as before and just skip the register read. Does this work for you?

Ah thanks for the explanation! I had actually tested a similar patch
but wasn't sure if nvme_start_freeze() also does register access for
starting the HW queues and if it makes sense on a dead/isolated device
at all. On the other hand this code very explicitly handles dead
devices so I guess this was kept in mind.

So yes the below patch works for me.

> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fdfee3e590db..c40e82cee735 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
>  static void nvme_dev_remove_admin(struct nvme_dev *dev)
> @@ -2690,9 +2772,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	mutex_lock(&dev->shutdown_lock);
> -	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
> -		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +	if (pci_is_enabled(pdev)) {
> +		u32 csts = ~0;
>  
> +		if (pci_device_is_present(pdev))
> +			csts = readl(dev->bar + NVME_REG_CSTS);
>  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
>  		    dev->ctrl.state == NVME_CTRL_RESETTING) {
>  			freeze = true;
> --


