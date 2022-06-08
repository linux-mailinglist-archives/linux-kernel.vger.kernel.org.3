Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5845429FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiFHIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiFHIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:49 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F6F2DB308;
        Wed,  8 Jun 2022 01:13:46 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id gl15so26019690ejb.4;
        Wed, 08 Jun 2022 01:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=FlnnCceqwMLD6qaSddjK32ci0ISYkaSfyXbFlZtBZBc=;
        b=swf4SymUP/RXrI243lpcHDxogw+zpAC5A/5QlOEOU+CHPrtCvFv2ByqXW0e2/UI6XG
         kO/pxzYiHaMK/7mWNRbHSyOynZFK5ZqJA3ePM/Lv3O4ws8SMbwXAC084NTAHWMEKVSOO
         OuaAv8k95QprYh2I2DSB5AMzybmAzSIeXm9BUgJLbbQELvp3tRY2tC57tk42n20NFCej
         zjaQBs40o/UtaS363XfB24IOEJkwaTvaWBUBcJSvBuw5Jdo05kMwog08CjSFD/meJAdR
         Z1/SNHWCeJr0TywTCmytJetBPCqiRl7zxQeRI6PUJRailMTEgX1F29WDyBbM9s26ACjm
         AApw==
X-Gm-Message-State: AOAM533NLkOXEvr7UQgzco+hahMVX8x2MiqjkFHTIRTGQ8fS4chLlvKT
        3BOKwJKaSlXpb7vtlMNRfzT675X7rfL1zQ==
X-Google-Smtp-Source: ABdhPJwjwyjqHqOlvpnbXNfRrNCAQNo/8X9GRGMwR0emiCeIdYz+eorJRBapSPMLHzI78uQAJO7uXQ==
X-Received: by 2002:a17:906:891:b0:70b:c30e:c1f1 with SMTP id n17-20020a170906089100b0070bc30ec1f1mr27171440eje.733.1654676024849;
        Wed, 08 Jun 2022 01:13:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r7-20020a056402018700b0042dc9aafbfbsm11714868edv.39.2022.06.08.01.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:13:43 -0700 (PDT)
Message-ID: <4b65d670-e2bb-27d3-ee19-3f8a39dfec4d@kernel.org>
Date:   Wed, 8 Jun 2022 10:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
 <5bf366cc45334bb9a9c3d186ef8d6933@AcuMS.aculab.com>
 <9780cd63-5cf3-7ee0-4866-160b9de0a3e8@kernel.org>
In-Reply-To: <9780cd63-5cf3-7ee0-4866-160b9de0a3e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 22, 10:11, Jiri Slaby wrote:
> Note that the patches try NOT to change the behavior in any way. If they 
> do, it's likely a bug. They are first front cleanup. Definitely more to 

Ah, in English, it's "first line".

-- 
js
suse labs
