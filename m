Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F347E8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbhLWVRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:17:41 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48318
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233222AbhLWVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:17:39 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07C0A3F1EE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640294257;
        bh=wSZODWSU4DKXu9p3Iy+JEhsRjXghL/NqBI5nvfYw29Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=n241tEQIMbkoiqvrG/EuCFQ6QwQO+2D0Dd76n9QN2No9n7UPswqvDB2LKgd2rBrH+
         v3eTPYdu99b/G0r2ZcykAJ434JqHEWK+gHUHifYM4ueS3HodSTeXAcU1wC2Q/DK1aq
         FS4qeENdsuUqDpfC3R/12sHW+woNHmzpGkhcIW3ihtlSDK44BFlO401E6Epa2rlnsF
         yQzjzvCp1I8gsJCmufItXztBxh0BVhkap4oosuv3vkFnHQkvkoUdhZ/SvO8vIc+2gk
         35P5fkE6DMMPaAtjybmamflY4XTtpEwobi33HJ2BXl+3LZO3jjc8mZffgC0CWra9KA
         sc8LP9kJ4l9tg==
Received: by mail-lj1-f198.google.com with SMTP id p21-20020a2e9ad5000000b00219ee503efeso1900833ljj.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 13:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wSZODWSU4DKXu9p3Iy+JEhsRjXghL/NqBI5nvfYw29Y=;
        b=VxSrFP6D+hcKvoquUuWkbpiylAXOSKPjiKvrTeCDWxXAfc+X3OIVl4mAXJWX6x/6Ix
         nLBA/wTDNhijiYXu+jPpQD7rvpUln8Oov8Rt69dzzOoj+KOSgCqpfMfU9suUDXvzROjH
         C/a8VSeafBfesE6LXbaa0i5mbs4co1IrQ5NIwop5LY0MaHIrQxR+e72o3GqIx3U5Tyc5
         cbKJchnh+0KW02owUidUR6GRxQc3U7mdMORr5NKXc6QKrxKwdDo3pNlRiCHQ3NZ+jyEL
         kXUOmo5bbpHouWV5J+cs1vzPH8YunXAb8xKXNUxHQF4nrbyWS8BL8D+XCuT0qaurSIw0
         NqTg==
X-Gm-Message-State: AOAM530sMTQvLyc0MnpBd6W5VoboLGisr203p4gQz/em/s51s4211YwD
        TF4WY2xXbBM/qAt6JdplBXqMIKBwwqfEVyAp76neyxhgL3Mc9v5QyEr5JKfO4nBriYfwXdo8HbU
        UsbbVE0/pMDF+bmqPGhfId4UkyGu8XKJ+/GTmtzAPPw==
X-Received: by 2002:a19:490f:: with SMTP id w15mr2944218lfa.278.1640294256081;
        Thu, 23 Dec 2021 13:17:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDB99L3XcrLuvZwJ9zWTCacN2IPGrVbY0jL0JnDc+/zEbdPYRnRWDt/Pvv8w5u+qTkCe7dTA==
X-Received: by 2002:a19:490f:: with SMTP id w15mr2944203lfa.278.1640294255840;
        Thu, 23 Dec 2021 13:17:35 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u8sm615629lje.91.2021.12.23.13.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 13:17:35 -0800 (PST)
Message-ID: <ce08a9b7-4fc5-2cc7-2a5a-dbab6eabea14@canonical.com>
Date:   Thu, 23 Dec 2021 22:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: linux-next: manual merge of the nand tree with the drivers-memory
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Roger Quadros <rogerq@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211223104704.35fa3a41@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211223104704.35fa3a41@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2021 00:47, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the nand tree got a conflict in:
> 
>   drivers/mtd/nand/raw/omap2.c
> 
> between commit:
> 
>   f2f8115fe8b3 ("memory: omap-gpmc: Use a compatible match table when checking for NAND controller")
> 
> from the drivers-memory tree and commit:
> 
>   0137c74ad873 ("mtd: rawnand: omap2: Add compatible for AM64 SoC")
> 
> from the nand tree.
> 
> I fixed it up (I used the former version and added the following patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 

Thanks Stephen, the fix looks correct.

Roger,
It seems you sent two separate patches touching exactly the same files
recently for two different trees. One for memory controllers moving the
NAND ids and second for MTD tree with adding new compatible.
Please don't, instead second should base on the other and these should
go via one tree. This is a non-trivial conflict which could be avoided.


Best regards,
Krzysztof
