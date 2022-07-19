Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D9579064
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiGSCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiGSCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:03:24 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95B3B97E;
        Mon, 18 Jul 2022 19:03:23 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IMIaO9011734;
        Mon, 18 Jul 2022 18:27:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=5p7YrDBdLa0/d/BEqV9bZhGLXEdirc45pHjB+sUzbD4=;
 b=fWoF6g4Y/U+hbPFUMNybgDLpwNaLQjVdTO5++xssFfoNp71rClstekSnpwWuqZvuPLIb
 bR77zlrY6pWKq0QYov4EImkM2rUXho9kUIoNaN1RiyEf+zF19QdDJ4/mn1k0nhyTi0pd
 ygCiKlXItofB8C6VJaWaQ2tTqLydNI+CYFGn3GyqVo5GNY66c2OMmpZjLtdjxuwMJ+L1
 IKnyg6zinlGateldFi6gZ7i8NQKPDopUg7Drub70mbWJOo28TfbfwMtdrO9aXRX/8ljF
 0o7CfMdEF+FZ/z0ICJQJPm1/Dfwv1fbaJ+L8SKY+Ne6jffbO9RO/5dkWX8kzQwZ7fjA4 4g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk5whmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 18:27:21 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B7BACC0649;
        Tue, 19 Jul 2022 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658194040; bh=IMazAZqLEBIxNJhRkGrUVaJ9d5nGkSk8QFUqoizUzzE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=k89Ay8ftqZ1RT3wNsQk+e1e+iMnyWDdzTE8wMPHs7M/+9ZmoVPdTcgLMZ4ydOHTCk
         JVvsw5Z1tuaFcGu4UsiIk70CTVA8yZo0Tflv1VxybNv4XkhM6f6FHODX+f7j7Iw8bA
         j7yEsv8m++CxJ1sCO6CrtkVbv7QhJU+28Afz/28GzI6RKwPIXN8+xNhpam1KTDnYy4
         wqnR8qknomZHi0nX1dLr5A9tbecXc4gsmj21hPpBVPhJHNH2I/6hJ1tr472NCb7j8Y
         iNIdNvkiuKrhrd2DtQ2eSbKJ/QLrVINIbDDyulHN2lWQQnWDWKJ9Te+qhBtlvM48AX
         KZ/X49NbIGaHA==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 7B91BA0068;
        Tue, 19 Jul 2022 01:27:19 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 18:27:19 -0700
Date:   Mon, 18 Jul 2022 18:27:19 -0700
Message-Id: <7e236a9022761be52c39638321b959cf0f00bc0c.1658192351.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 12/25] usb: gadget: f_tcm: Minor cleanup redundant code
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Proofpoint-GUID: FWOJ_yoTyd55J047IesOkj-qf3NbchPn
X-Proofpoint-ORIG-GUID: FWOJ_yoTyd55J047IesOkj-qf3NbchPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=888 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status request preparation is done in uasp_prepare_status(). Remove
duplicate code. No functional change here.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/gadget/function/f_tcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index ec83f2f9a858..53b178ad4f90 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -624,8 +624,6 @@ static int uasp_send_status_response(struct usbg_cmd *cmd)
 	struct sense_iu *iu = &cmd->sense_iu;
 
 	iu->tag = cpu_to_be16(cmd->tag);
-	stream->req_status->complete = uasp_status_data_cmpl;
-	stream->req_status->context = cmd;
 	cmd->fu = fu;
 	uasp_prepare_status(cmd);
 	return usb_ep_queue(fu->ep_status, stream->req_status, GFP_ATOMIC);
-- 
2.28.0

