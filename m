Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688C752C87D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiESAST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiESASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:18:12 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3F15A75D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:18:08 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220519001806epoutp042315ba0f82e4f81e0949270c91b4b55c~wWYPy11qw2716527165epoutp04c
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220519001806epoutp042315ba0f82e4f81e0949270c91b4b55c~wWYPy11qw2716527165epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652919486;
        bh=PRd8L2POYaDdIOu7WXaO1NelHeOJKJdUTwyxOMOKsvE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bQ0a12yZXEInUhaoMyMV7aEB6lHgB0dYUQBd7WLgNbN3UgvvvAzqldFDgiUvgsBHa
         PTP6hcTnf/JgVhlKl1EVOgC+dERkrdlaEfYxQcCAKKmiMPHekhMJjVLuJaTiN2oU36
         4U3JhrFclXUdQKgGpptmUPqeBSX8nmFJ8k1TXzMU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220519001805epcas1p14239bb46c5690a15fc2ebde221327c1d~wWYPOqX-u1075210752epcas1p1E;
        Thu, 19 May 2022 00:18:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.234]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L3Vn85xRYz4x9QK; Thu, 19 May
        2022 00:18:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.06.10354.CBC85826; Thu, 19 May 2022 09:18:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220519001804epcas1p458a680b461d95212a798acf9496cb29d~wWYN4ZqYS0814408144epcas1p4m;
        Thu, 19 May 2022 00:18:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220519001804epsmtrp18c531a7dc8abedf97ebd1b0392067964~wWYN3pCIP2287122871epsmtrp1R;
        Thu, 19 May 2022 00:18:04 +0000 (GMT)
X-AuditID: b6c32a38-4b5ff70000002872-dc-62858cbce6a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.55.11276.CBC85826; Thu, 19 May 2022 09:18:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220519001804epsmtip2768909efc722b88a1da9b31c3505154e~wWYNjfnpP0196201962epsmtip2I;
        Thu, 19 May 2022 00:18:04 +0000 (GMT)
Subject: Re: [PATCH v5 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <03d9b2db-2860-8eb6-65c3-df9f985ce8c0@samsung.com>
Date:   Thu, 19 May 2022 09:44:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <59f53724-87fe-97b8-0660-dcb1a5b464fe@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmvu6entYkg9un9C22r3/BajGhdTuz
        xfH9S9gtjv0Ktjjb9Ibd4vKuOWwWn3uPMFqsPXKX3eLzhseMFrcbV7BZdB36y2Yxo+0yqwOP
        x+yGiyweCzaVerSc3M/i0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz3q59x1ywQLdiS1s7awPjdtUuRk4OCQETibfb
        DjOD2EICOxglprYFdzFyAdmfGCUe7t3OBuF8Y5R48XkBK0zHixu9LBCJvYwSk4/sYoZw3jNK
        XF36AWyWsECsxL43z8FsEYFMiSPnXrGCFDELPGaU+L7kDdgoNgEtif0vbrCB2PwCihJXfzxm
        BLF5Bewk1r59CBTn4GARUJW4+88JJCwqECZxclsLVImgxMmZT1hASjgF7CVe34sFCTMLiEvc
        ejKfCcKWl9j+dg7YbRICBzgkNjf+Zof4wEXi0JHlULawxKvjW6BsKYmX/W3sEA3NjBINL24z
        Qjg9jBJHn/WxQFQZS+xfOpkJZDOzgKbE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQii
        RFni8oO7TBC2pMTi9k62CYxKs5C8MwvJD7OQ/DALYdkCRpZVjGKpBcW56anFhgUm8NhOzs/d
        xAhOuVoWOxjnvv2gd4iRiYPxEKMEB7OSCC9jbkuSEG9KYmVValF+fFFpTmrxIUZTYPhOZJYS
        Tc4HJv28knhDE0sDEzMjYxMLQzNDJXHe3qmnE4UE0hNLUrNTUwtSi2D6mDg4pRqYrDKf3Hvz
        cWNZNUfMoz07jsX0SS5kuem7466EXeGthPrlK+Uta+Z8u8CQwvdEqJyvRydkQcSB3TN3bHt2
        2/NGQcvb3U+3sjM4O8+5KHhQcOVuj9JPvOobNedoGU5aZJe4ekNm4d0FOxqMVrQGXUyWMXmS
        oLhauGb7n/UZqRse3HvfFxrZJv+4/Xb9N53bykfOCq+vur//muS+jL5uRpd3263Omh7aeId5
        SejE2Z+Skn+m6h15++bctCvxV1vsVhw08Dunm7j9lWXmvr7C6XWLpmny2DEomwfLiHnyd8m7
        6aXULnrqquCpZ7iWKYxH98Ku8j1fzracO77V6qye7oz+gJhn62v6ay2EQh5qbFkbrMRSnJFo
        qMVcVJwIAK9P/gdCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO6entYkg86NQhbb179gtZjQup3Z
        4vj+JewWx34FW5xtesNucXnXHDaLz71HGC3WHrnLbvF5w2NGi9uNK9gsug79ZbOY0XaZ1YHH
        Y3bDRRaPBZtKPVpO7mfx6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroy3a98xFyzQrdjS1s7a
        wLhdtYuRk0NCwETixY1eli5GLg4hgd2MEvPWrWaDSEhKTLt4lLmLkQPIFpY4fLgYouYto8TD
        t9uZQWqEBWIl9r15DmaLCGRK7Nh/kQmkiFngMaPE5fkPoKYeZpS4c6ENrIpNQEti/4sbYBv4
        BRQlrv54zAhi8wrYSax9+5ANZBuLgKrE3X9OIGFRgTCJnUseM0GUCEqcnPmEBaSEU8Be4vW9
        WJAws4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoPAtJ9ywkLbOQtMxC0rKAkWUVo2RqQXFu
        em6xYYFhXmq5XnFibnFpXrpecn7uJkZw7Glp7mDcvuqD3iFGJg7GQ4wSHMxKIryMuS1JQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAl/dza6vJc1Kpu
        7nzeOE9fHwfJ6ccFPC8zFs97nK/1+lbBPqbL4sVZrjc/HV/U76Cy8zhfe+TjvR/e6VY1JS5W
        eLJ1lbGDcGpOXPja3jUHPnV5LU/8fP/u6g6f1mirfqY7TKuObdvPvUt09eu1LCe8+4q4409J
        9WkoZZhE32Zrf2V7p+qV3ErLvKnmLVKrnl/5tjUs5WCe8y75Qq+javVL99dE7FaJl9M7F+Pw
        QWFhaReL8NyTl1idnv1a3P3+5JSU+3YFSbZquUeey+bELb9/dm7O/MeXfE/INzHXKup2d/ok
        1H6+pxOx3GkJo5zpDh6XraFLH1paLOCed/mDxdu5IfbWEycl1Kl9v8ccrqHEUpyRaKjFXFSc
        CACTJJWGLAMAAA==
X-CMS-MailID: 20220519001804epcas1p458a680b461d95212a798acf9496cb29d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
References: <CGME20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97@epcas1p4.samsung.com>
        <20220517092108.31680-1-cw00.choi@samsung.com>
        <59f53724-87fe-97b8-0660-dcb1a5b464fe@samsung.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,


I send the previous mail without detailed my reply
because of my mistake.

Thanks for the report.
I fix this issue as following: I'll send patch. Thanks.

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 7306e943a234..72c67979ebe1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -402,7 +402,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 {
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
-	int ret = -EINVAL;
+	int ret = 0;
 
 	if (!p_data)
 		return -EINVAL;
-- 
2.17.1



On 5/18/22 7:56 PM, Marek Szyprowski wrote:
> Hi,
> 
> On 17.05.2022 11:21, Chanwoo Choi wrote:
>> The devfreq passive governor has already supported the devfreq parent device
>> for coupling the frequency change if some hardware have the constraints
>> such as power sharing and so on.
>>
>> Add cpu based scaling support to passive governor with required-opp property.
>> It uses the cpufreq notifier to catch the frequency change timing of cpufreq
>> and get the next frequency according to new cpu frequency by using required-opp
>> property. It is based on patch[1] and then just code clean-up by myself.
>>
>> Make the common code for both passive_devfreq and passive_cpufreq
>> parent type to remove the duplicate code.
> 
> I've just tested it on Exynos based boards and on all I see the 
> following issues after system suspend/resume cycle:
> 
> # time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Wed May 18 11:13:16 2022
> PM: suspend entry (deep)
> Filesystems sync: 0.001 seconds
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> 
> ...
> 
> devfreq soc:bus-disp1-fimd: failed to suspend devfreq device
> devfreq soc:bus-jpeg-apb: failed to suspend devfreq device
> devfreq soc:bus-jpeg: failed to suspend devfreq device
> devfreq soc:bus-g2d-acp: failed to suspend devfreq device
> devfreq soc:bus-g2d: failed to suspend devfreq device
> devfreq soc:bus-peri: failed to suspend devfreq device
> devfreq soc:bus-gen: failed to suspend devfreq device
> devfreq soc:bus-mfc: failed to suspend devfreq device
> devfreq soc:bus-fsys2: failed to suspend devfreq device
> devfreq soc:bus-fsys-apb: failed to suspend devfreq device
> devfreq soc:bus-noc: failed to suspend devfreq device
> ...
> Disabling non-boot CPUs ...
> Enabling non-boot CPUs ...
> ...
> devfreq soc:bus-mscl: failed to resume devfreq device
> devfreq soc:bus-gscl-scaler: failed to resume devfreq device
> devfreq soc:bus-disp1: failed to resume devfreq device
> devfreq soc:bus-disp1-fimd: failed to resume devfreq device
> devfreq soc:bus-jpeg-apb: failed to resume devfreq device
> devfreq soc:bus-jpeg: failed to resume devfreq device
> devfreq soc:bus-g2d-acp: failed to resume devfreq device
> devfreq soc:bus-g2d: failed to resume devfreq device
> devfreq soc:bus-peri: failed to resume devfreq device
> devfreq soc:bus-gen: failed to resume devfreq device
> devfreq soc:bus-mfc: failed to resume devfreq device
> devfreq soc:bus-fsys2: failed to resume devfreq device
> devfreq soc:bus-fsys-apb: failed to resume devfreq device
> devfreq soc:bus-noc: failed to resume devfreq device
> 
> Some boards (like Trats2) after suspend/resume cycle reveals random crashes.
> 
> All those issues were not observed before applying this patchset.
> 
>> [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
>> - https://lore.kernel.org/patchwork/patch/1101049/
>>
>> Changes from v4:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20220511093554.17535-1-cw00.choi@samsung.com/
>> - Fix issue[2] reported by Marek Szyprowski
>> [2] https://patchwork.kernel.org/project/linux-pm/patch/20220511093554.17535-3-cw00.choi@samsung.com/
>>
>> Changes from v3:
>> : ttps://patchwork.kernel.org/project/linux-pm/cover/20220509120337.92472-1-cw00.choi@samsung.com/
>> - Add tested-by tag of both Chen-Yu Tsai and Johnson Wang
>> - Fix some typo
>>
>> Changes from v2:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
>> - Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
>> - Move p_data->this initialization into cpufreq_passive_regiser_notifier()
>>
>> Changes from v1:
>> : https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
>> - Rename cpu_data variable to parent_cpu_data to avoid build fail
>> - Use for_each_possible_cpu macro when register cpufreq transition notifier
>> - Add missing exception handling when cpufreq_passive_register_notifier is failed
>> - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
>>    the memory waste when NR_CPU is too high.
>> - Add reviewed-by tag of Matthias Kaehlcke for patch1
>>
>> Chanwoo Choi (3):
>>    PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>>    PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>>    PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>>
>> Saravana Kannan (1):
>>    PM / devfreq: Add cpu based scaling support to passive governor
>>
>>   drivers/devfreq/devfreq.c          |  20 +-
>>   drivers/devfreq/governor.h         |  27 ++
>>   drivers/devfreq/governor_passive.c | 403 ++++++++++++++++++++++++-----
>>   include/linux/devfreq.h            |  17 +-
>>   4 files changed, 389 insertions(+), 78 deletions(-)
>>
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
