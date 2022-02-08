Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AE4AD0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiBHFcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347062AbiBHEwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE81C0401DC;
        Mon,  7 Feb 2022 20:52:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2183uVSr027133;
        Tue, 8 Feb 2022 04:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=xgk2f2y/iNVywQZQfPWIywaeBsaMp90RYHlfbDrhJhc=;
 b=bZpwBmPTndpnTzxwBTIxJPf2uLjUmlNG+uOQ8qSifjt9B3GdXjbwIA2qxYuO5d6ymjrE
 Hg7vVgN91WFBvelsuMj7fCLqX7LwxrdunrJpiUs2N0geGHCSRcXwaEeoNzuZOjkfcE7Y
 Gg/192HY6mM0mWfKb3/6XiQy4aNhbDmgSTABSwy6/Hd83o2Va9GSUFuuvoXGhx+2o4Xr
 BH28bYBzIfKlLAfHhNWguZj02Ete7v0S0Zllv92kjOXOKbwg8L87hkQkBSkXVJH8bTpk
 3f/X1sgI3wxAqm91Byi+6gdfUaP9dX5bp9rj1sUCfWCca8dhE4Vr0OdrClG4uiZ195GF sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28g3jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1tR088293;
        Tue, 8 Feb 2022 04:52:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKi5089147;
        Tue, 8 Feb 2022 04:52:29 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-7;
        Tue, 08 Feb 2022 04:52:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>, jejb@linux.ibm.com,
        GR-QLogic-Storage-Upstream@marvell.com, skashyap@marvell.com,
        jhasan@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: Make use of the helper macro kthread_run()
Date:   Mon,  7 Feb 2022 23:52:18 -0500
Message-Id: <164429583888.16454.4684911888416516463.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220126014248.466806-1-yinxiujiang@kylinos.cn>
References: <20220126014248.466806-1-yinxiujiang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 04krdoPEXj2p3g1K8kog_k8diDVVrTRW
X-Proofpoint-GUID: 04krdoPEXj2p3g1K8kog_k8diDVVrTRW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 09:42:48 +0800, Yin Xiujiang wrote:

> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: bnx2fc: Make use of the helper macro kthread_run()
      https://git.kernel.org/mkp/scsi/c/687ba48e16e4

-- 
Martin K. Petersen	Oracle Linux Engineering
