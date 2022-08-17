Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4C5970B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiHQOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbiHQOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:10:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC472BB1E;
        Wed, 17 Aug 2022 07:10:38 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 635C8660159D;
        Wed, 17 Aug 2022 15:10:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660745437;
        bh=800RC4ICkbDmhsqVW2aoXXz19mRXLW32RQKJ2uMQKM0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M7aUifx9KeQns+dDyP9sZSXqRhTtgvqLT+7vUAkfVi6ANb4X54d1nQyQpvRnDjKhA
         D7OMf1XhTgZq27DEpqe9xosatYWCP8PLslavQFK5X/Wq146BlY/CPoC8uIQpejxOPZ
         dc1Ji46HdJ9io2ViNSsCjuWJ4KzKlWO+OX6wf93iNAzjDaybTsbF6zBntrR8vvzaCF
         0lCTtVN3xAxUDPMubSlK3N5h/91ae/6Sj0dtTjWhQEJLvSWNPapZfQz/Bs5peP8jwC
         5MyrhaD2DTet34vKUNjObpm3WReNsiF0zSUtm14tqKBB4XQvH+z1qC54b2jPzxZ9wY
         j8tIp0X1xyJKA==
Message-ID: <3e2a0f50-c396-5af6-5cbe-303978378587@collabora.com>
Date:   Wed, 17 Aug 2022 19:40:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] spi: amd: Configure device speed
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220817131809.312533-1-shreeya.patel@collabora.com>
 <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/08/22 19:14, Mark Brown wrote:
> On Wed, Aug 17, 2022 at 06:48:09PM +0530, Shreeya Patel wrote:
>
>> Create mechanism to configure device clock frequency such
>> that it is the closest frequency supported by the
>> AMD controller.
> You shouldn't use the closest, you should use a frequency which is
> strictly less than the requested one - driving things too fast will
> generally break but too slow is pretty much always fine.
Hi Mark,

yes, the code is actually configuring it to use the frequency which is 
strictly less than the requested one.
I just didn't use the correct words. I will make the change in commit 
message for v2 once you review the patch.


Thanks
Shreeya Patel

