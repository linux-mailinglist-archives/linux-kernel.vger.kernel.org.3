Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F84C8969
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiCAKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiCAKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:38:57 -0500
X-Greylist: delayed 4198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 02:38:16 PST
Received: from 20.mo584.mail-out.ovh.net (20.mo584.mail-out.ovh.net [46.105.33.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8A12AF7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:38:14 -0800 (PST)
Received: from player771.ha.ovh.net (unknown [10.109.146.1])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 1D1ED22DB2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:19:02 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id CEE3927FF4D6E;
        Tue,  1 Mar 2022 09:18:58 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 01 Mar 2022 10:18:58 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmem: check for allocation failure
In-Reply-To: <20220301081127.GC17375@kili>
References: <20220301081127.GC17375@kili>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <02cec796f9e50e0895b28c5000ea2254@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16502596412997479291
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejffdufffgjefgvdeigedukefffeevheejueeikeehudeiudehvdeifeduteehieenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01 09:11, Dan Carpenter wrote:
> Check for if the kcalloc() fails.
> 
> Fixes: 299dc152721f ("nvmem: brcm_nvram: parse NVRAM content into NVMEM 
> cells")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thank you!

Acked-by: Rafał Miłecki <rafal@milecki.pl>

> ---
>  drivers/nvmem/brcm_nvram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 439f00b9eef6..c80af8a31eba 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -95,6 +95,8 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
>  	len = le32_to_cpu(header.len);
> 
>  	data = kcalloc(1, len, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>  	memcpy_fromio(data, priv->base, len);
>  	data[len - 1] = '\0';
