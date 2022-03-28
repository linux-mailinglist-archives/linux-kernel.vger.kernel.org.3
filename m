Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5994E8CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 06:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiC1EQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiC1EQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:16:02 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C732BE0;
        Sun, 27 Mar 2022 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=IF16B
        0yv19zZc01NeFBPavL6NxNzXPk7y4Wk30giGb0=; b=VXziEzz2vFqXRJrSvAYgd
        5tw1FaiZsEwpN3ussvTbPeflVO3lpRrBjI8uKTBn/9/Qa7stSyxq9bdGdhs00ACF
        izxf4fr0ziDfk2YHh8on8Yhje424q455TIf1+6NEAUmiwV6e/adjyOyzT2wlL+7d
        pqV7e6iP17zTYh0M3JmMXQ=
Received: from [192.168.1.105] (unknown [159.226.95.33])
        by smtp9 (Coremail) with SMTP id DcCowAB3fXn0NUFieLEdCw--.43334S2;
        Mon, 28 Mar 2022 12:13:40 +0800 (CST)
Subject: Re: [PATCH v1] soc: bcm: Check for NULL return of devm_kzalloc()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
References: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
 <0f5e77e9-3c2c-396d-636b-1b7153007fe5@omp.ru>
Cc:     bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
From:   QintaoShen <unSimple1993@163.com>
Message-ID: <37a63518-5d68-fddf-a10b-1aad2c2302c1@163.com>
Date:   Mon, 28 Mar 2022 12:13:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f5e77e9-3c2c-396d-636b-1b7153007fe5@omp.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DcCowAB3fXn0NUFieLEdCw--.43334S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy8ZrykZw45trWfXr4fXwb_yoW8Aw1xpF
        4fGFy0yrZ5K3yUA3ZrZ3WkuF98J34xtFyYk34xWwn3Za1DtF1Sgr9xGFyFvr1rAFW8CF4I
        yFy7t343u3W5Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziQVyDUUUUU=
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiXxXRH115322PggAAsf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Here is the new version.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
  drivers/soc/bcm/bcm63xx/bcm-pmb.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c 
b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 7bbe46e..cc20ffb 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -312,6 +312,9 @@ static int bcm_pmb_probe(struct platform_device *pdev)
      for (e = table; e->name; e++) {
          struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), 
GFP_KERNEL);

+        if (!pd)
+            return -ENOMEM;
+
          pd->pmb = pmb;
          pd->data = e;
          pd->genpd.name = e->name;
-- 
2.7.4

在 2022/3/25 下午5:02, Sergey Shtylyov 写道:
> Hello!
>
>     s/return/result/ in the subject.
>
> On 3/24/22 11:35 AM, QintaoShen wrote:
>
>> As the potential failuer of allocation, devm_kzalloc() may return NULL.
>> Then the 'pd->pmb' and the follow lines of code may bring null pointer dereference.
>     Following.
>
>> Therefore, it is better to check the return value of devm_kzalloc() to avoid this confusion.
>>
>> Signed-off-by: QintaoShen <unSimple1993@163.com>
>> ---
>>   drivers/soc/bcm/bcm63xx/bcm-pmb.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
>> index 7bbe46e..55bf389 100644
>> --- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
>> +++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
>> @@ -311,6 +311,8 @@ static int bcm_pmb_probe(struct platform_device *pdev)
>>   
>>   	for (e = table; e->name; e++) {
>>   		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>     Please keep an empty line after declaration.
>
>> +		if (!pd)
>> +			return -ENOMEM;
>>   
>>   		pd->pmb = pmb;
>>   		pd->data = e;
> MBR, Sergey

