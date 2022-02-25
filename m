Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078C4C448C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiBYMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiBYMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:23:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485920DB34;
        Fri, 25 Feb 2022 04:23:00 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PBMmcS033280;
        Fri, 25 Feb 2022 12:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=psUjqUDIXrQuDk/0U0G6bTiHSZGQTDTjSpKnanVkLOU=;
 b=C9VXNBfrBDhDc8KObk6NsCnVFIFb8LpS7RxunFyXY51/VhKLVTZz3iRXBc34CT4dHcvT
 GZZ6KWKZKpFWHcmralHqPLGOkoDTgYTVkEfYtal6M+jF1CI0oaE+/4zERNu3LmmsUwJC
 /0mv3GSl02qg2qKaWcyuT96FO7QI00bpvtXhx24+0IATu4ws7bLeeRgTWOCzotp8qOdk
 0TWZunph8PM5ua4RLs9F1bBPdjiflcVBXwBFz/JQwnGUdNieLIdXaeS0803Hf8Pg7Ycr
 0QNVAQVA6jnfsq4l1VdvAjcSYVdIqEl0l2/B0JHGZvvmngiEuapSBcYtdYcJFhoHp0KZ VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eewpn291c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 12:22:41 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PBQta4004716;
        Fri, 25 Feb 2022 12:22:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eewpn290a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 12:22:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PCIwCq030560;
        Fri, 25 Feb 2022 12:22:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69rf5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 12:22:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PCBqMg14745858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 12:11:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D912B52054;
        Fri, 25 Feb 2022 12:22:35 +0000 (GMT)
Received: from [9.145.163.29] (unknown [9.145.163.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3FB7952059;
        Fri, 25 Feb 2022 12:22:35 +0000 (GMT)
Message-ID: <65d40e00-d7a4-0210-5253-d5d1744f0343@linux.ibm.com>
Date:   Fri, 25 Feb 2022 13:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [next] next-20220223 kernel crash
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
References: <CA+G9fYtzLr+9T9Z1N8QLznW6DqTOU8iSHvgMftdhe2XkEf8F8g@mail.gmail.com>
From:   Steffen Maier <maier@linux.ibm.com>
In-Reply-To: <CA+G9fYtzLr+9T9Z1N8QLznW6DqTOU8iSHvgMftdhe2XkEf8F8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8iR0yfi5CRn2OiGcAc3R2PeQ1PHYEQN4
X-Proofpoint-ORIG-GUID: jXsduC_UmntOMfiR-ERJZIlWIGPVZ4ni
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_07,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=966 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 14:28, Naresh Kamboju wrote:
> Linux next-20220223 boot failed due to the kernel crash on all devices.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> crash log on x86_64 machine [1]:
> [    5.326681] Please do not flush events WQ.
> [    5.327480] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.17.0-rc5-next-20220223 #1

Is this related?:
https://lore.kernel.org/all/4e5fe60d-abbb-6e73-b8cc-c3e1a314fbce@samsung.com/T/#u


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z and LinuxONE

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschaeftsfuehrung: David Faller
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
