Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0C4878FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbiAGOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:32:59 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:58698 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233190AbiAGOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:32:58 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADXbaYAT9hh3kz7BQ--.38327S2;
        Fri, 07 Jan 2022 22:32:32 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] thermal/int340x_thermal: Check for null pointer after calling kmemdup
Date:   Fri,  7 Jan 2022 22:32:30 +0800
Message-Id: <20220107143230.4057632-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADXbaYAT9hh3kz7BQ--.38327S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UCw45Zr1kGF1xuFW7Jwb_yoW8Xr4kpF
        WSgryUArZYgF48XwnrAr15Ja98C3Z5Ka95uFyFga4YyFnIyFWSgFyFyF1Ykry0kr1xKw1j
        ya4YqFs7ZryDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5XwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjc183UUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:05:17PM +0800, Daniel Lezcano wrote:
>> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> index 823354a1a91a..999b5682c28a 100644
>> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
>> @@ -462,6 +462,11 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>>  	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
>>  				   obj->package.elements[0].buffer.length,
>>  				   GFP_KERNEL);
>> +	if (!priv->data_vault) {
>> +		kfree(buffer.pointer);
>> +		return;
>> +	}
>> +
>
> There is another kfree on error before
>
> Please replace those by a goto out_kfree;
>
>>  	bin_attr_data_vault.private = priv->data_vault;
>>  	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
>
> out_kfree;
>>  	kfree(buffer.pointer);
>> 

Ok, I will submit new patch to replace those.

> Why there is no error code returned to the caller?

Well, I check the commit 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
and find that it was designed to return without error.
And it seems that the 'bin_attr_data_vault.size' is related to the
'bin_attr_data_vault.private'.
If the size is 0, then the array will not be used.
Therefore, I think it is unnecessary to return error.

Sincerely thanks,
Jiang

