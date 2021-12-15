Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359DB47549C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbhLOIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:52:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48398 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240934AbhLOIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:52:39 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BF7gjRf030002;
        Wed, 15 Dec 2021 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2J1ribNNKGa2+n1R4Zv8pbfAcOMU0iSIpnvv3Q+3k1E=;
 b=kQyFx+JfaGqIiWI08d5JBjNQIyTPEo2MhTKOrN2GsG2VyeHKDYC/p1bq9lx3/mXNb56f
 AViuwtay1rGazCQCvdwThkzyJIiMIYaEANtBNEOKLXaFUwfhI/GN7mRSLtEJhaXjp/hC
 0aMTzer3TinJcX5LH0jTnZYkBCqY9UakIUraOt1vHABfi/TLOYhlwmKsr9VKMTdUdzVX
 cSzdXTWN0hk8Hs5uOdOM5PsA1zlaYxDiV9/GKUYlV5DFzbETEJvW917zjnypS1j93qeO
 Z6mQAQ4XmrP4rUsQ1bmGeREBbu7wUQSuZblGiI6XhdyIshPd8P47aHLzJLQNEDl7mip6 Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8412a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 08:52:28 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BF8kPZ4032101;
        Wed, 15 Dec 2021 08:52:28 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cx9r8411y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 08:52:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BF8X9G7003310;
        Wed, 15 Dec 2021 08:52:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cy7qvtqsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 08:52:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BF8iO8C41025822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 08:44:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5264AAE053;
        Wed, 15 Dec 2021 08:52:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07875AE075;
        Wed, 15 Dec 2021 08:52:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 08:52:22 +0000 (GMT)
Received: from [9.43.169.195] (unknown [9.43.169.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B487A6015D;
        Wed, 15 Dec 2021 19:52:12 +1100 (AEDT)
Subject: Re: [PATCH misc-next] drivers/misc: remove redundant rc variable
To:     cgel.zte@gmail.com, fbarrat@linux.ibm.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211215060438.441918-1-chi.minghao@zte.com.cn>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <789ac279-ce90-5845-e3c0-e5c4b3ff1753@linux.ibm.com>
Date:   Wed, 15 Dec 2021 19:52:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215060438.441918-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nYYBK1Jr8T5-wduQnzr09b3X2UkN5WT0
X-Proofpoint-ORIG-GUID: yWY2CMR6rTcknYAKvEefpmzLC7-EwMkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_06,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxlogscore=768 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/21 5:04 pm, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ocxl_context_attach() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
