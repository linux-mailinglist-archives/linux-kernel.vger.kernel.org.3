Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708A547C9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhLUX2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:28:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237379AbhLUX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:28:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLg29G030372;
        Tue, 21 Dec 2021 23:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5Q5nX0xPxlbdmfm+TOYaEU9eV542ne1Rzw3ZwZVZQxc=;
 b=CP4BTk2rtNfZu1903JoSu98tig09Q+D+AdboHDxMHotziaSWttdGvJd+72xlz1888FCm
 n3DUNdjrF5tl82eUQTp4jDXA8sOcT/mZu5pHNYshiLo2ZJhBYTYQ4Q24a48m8XhSlH9n
 CQWLtP+A6NRIIiOasJ52O38I9dLGtCefrSzPVbIyelHP1Q557N4v4cn7/KvucwdmT7iZ
 9kLTH7ZHjZi53D/1wp/CLBGIjf6ZN2QIXZAIH/EfxRiSqJMFkwbxUtC2sZy9KKF9HsgX
 5GpVEdB1fvbHd5V0k/cVdNAMVgc4p0ZVSkxqXYU2ztx7mHVZvFqudMNu1j4VFyedk3Gy Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3f0auh6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 23:28:38 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLNSbET000958;
        Tue, 21 Dec 2021 23:28:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d3f0auh6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 23:28:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLNMk3U007083;
        Tue, 21 Dec 2021 23:28:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wjsmku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 23:28:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLNSXCN26804562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 23:28:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B3FBA4054;
        Tue, 21 Dec 2021 23:28:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 012CAA405B;
        Tue, 21 Dec 2021 23:28:32 +0000 (GMT)
Received: from sig-9-65-67-220.ibm.com (unknown [9.65.67.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 23:28:31 +0000 (GMT)
Message-ID: <9b93e099fc6ee2a56d70ed338cd79f2c1ddcffa5.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Do not load MOK and MOKx when secure boot be
 disabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Date:   Tue, 21 Dec 2021 18:28:31 -0500
In-Reply-To: <20211218020905.7187-1-jlee@suse.com>
References: <20211218020905.7187-1-jlee@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uQeJ8f_8ZN-B_o8ZQ_exHqD5LVj-hBYw
X-Proofpoint-GUID: Tc_s0b3RL0D8sWFFCGoJoXmr8vfhRfAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_07,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-18 at 10:09 +0800, Lee, Chun-Yi wrote:
> The security of Machine Owner Key (MOK) relies on secure boot. When
> secure boot is disabled, EFI firmware will not verify binary code. Then
> arbitrary efi binary code can modify MOK when rebooting.
> 
> This patch prevents MOK/MOKx be loaded when secure boot be disabled.
> 
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks, Joey!

This patch is now queued in the next-integrity-testing branch waiting
further review/tags.

Mimi

