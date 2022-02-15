Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1AE4B723E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiBOO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:58:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiBOO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:58:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550496276;
        Tue, 15 Feb 2022 06:58:05 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEm9uF022689;
        Tue, 15 Feb 2022 14:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DwMvSIbU3ZH+m1p41II1pEvA0O1v1hVXVvv5/UgubV0=;
 b=fqVOGZIQJl+iCO8KKegHYEJkQyeN5jY8OOg9yKud0ISbhR0BogmAmwPhPkx73isPAK0F
 TBgk7Jubj6PsABhibZqlVE46E2ajvXVRlsWaMPGF0+cw1YmmyIAfm5ZYi2/kOY+z/xAo
 woNRpuC2i2mzVkq6UBreFISfQOL/gTaE2+A9hBXbG14zZtXMGbHSbiROTnvaCmkThhEv
 xAvBsPAD1QgqSKJnaHpf3ctrId/DWNQp2TU8P6bTBjt3w/8+Bo3cG++AWVcwTNcJjA7Y
 77qozoC77Ae9vSm5RygkV/H//SmShOIgC0V0FkWp0aimBqKkdvhxedgslLyPWTYzZa/C UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8dxb8ugk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 14:58:04 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21FEmxv9025781;
        Tue, 15 Feb 2022 14:58:04 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e8dxb8ufv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 14:58:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FEkXUD021484;
        Tue, 15 Feb 2022 14:58:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jrg6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 14:58:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FEw0da22020476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:58:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EED2A4059;
        Tue, 15 Feb 2022 14:58:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 553D9A404D;
        Tue, 15 Feb 2022 14:57:59 +0000 (GMT)
Received: from sig-9-65-71-246.ibm.com (unknown [9.65.71.246])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 14:57:59 +0000 (GMT)
Message-ID: <bd513c794ca096ff037c289e793e0ebaf5f0225f.camel@linux.ibm.com>
Subject: kernel-parameter.txt question
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-doc <linux-doc@vger.kernel.org>
Cc:     Yael Tzur <yaelt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Feb 2022 09:57:58 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QZ31ezTWSLA1xslLJXrfV_3KBm0lOAUJ
X-Proofpoint-GUID: B6zW6hsqKrNKbD1GNnXtvsXOcGyQcx4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=794
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

When a new module parameter is defined, which will normally be
specified on the boot command line, should it be included in
Documentation/admin-guide/kernel-parameters.txt?

Example:  module_param(user_decrypted_data, bool, 0);

Message-Id: <20220215141953.1557009-1-yaelt@google.com>

-- 
thanks,

Mimi

