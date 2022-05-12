Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847E52459C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiELGXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350280AbiELGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:23:12 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B79CA5710D;
        Wed, 11 May 2022 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=rhTME
        NYSOsfI37FnghuXHxFoK+Ars+jOQTa9yaXuOxs=; b=eiqZCGRM9VBFw9tZNbSX8
        JOIN4cqZ2ifVSM1VYGY+nbxBerFd0SXYdWsmnimlAfIXl4ksZJZcweuSM1P8jTsT
        bNUmRYgjys0dQjrJoJhlbTq4XK5FkXkScKOD9ubt2doiAlR57+2aUobiFYAqmgmb
        Xcm+Dtw5tAVLaNEQcVqgMI=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp7 (Coremail) with SMTP id C8CowACXlHmpp3xit+KCCA--.5483S2;
        Thu, 12 May 2022 14:22:34 +0800 (CST)
Message-ID: <4e5a263d-462b-b17a-d4c2-2b8b02faa589@163.com>
Date:   Thu, 12 May 2022 14:22:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] drivers: cpufreq: sun8i-r40: Add cpufreq support
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220510003611.1812-1-qianfanguijin@163.com>
 <1902551.yKVeVyVuyW@kista> <01c2c11f-71fd-b735-b935-109865d62de5@163.com>
 <20220512045838.tvixosxbey5ksp6j@vireshk-i7>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220512045838.tvixosxbey5ksp6j@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACXlHmpp3xit+KCCA--.5483S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4DCw4xJFykuF43Cr1UAwb_yoW3CFc_Gr
        Z8Zry0y392qF1rtayfKrn7G39rGa9rCrWUAryrJFs3t3yFva45XayDCa1qqa4UKw409F9r
        Xw1Yyr4UWFZ09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjiFxUUUUUU==
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGgr+7VaEBicASAAAs4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/12 12:58, Viresh Kumar 写道:
> On 12-05-22, 12:34, qianfan wrote:
>> Actually I'm not make sure the difference, seems both of them can work.
>> Most of allwinner device_id is added in allowlist, so I did this.
> For OPP V1 the cpufreq device isn't created by default and hence the allowlist
> allows us to know the devices for which the device shall be created.
>
> For OPP V2, we have the compatible string available and with help of that we
> create a device without need of any entry to any list. The blocklist however
> allows us to skip creating the device for some platforms, which don't want it.
>
> As your case is opp-v2 and you want the device, you aren't required to add entry
> anywhere.
I read the source code again and understand the behaivors.
And I will it from allowlist.

Thanks
>

