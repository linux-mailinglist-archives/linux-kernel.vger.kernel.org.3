Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861FA5573E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiFWH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiFWH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:26:27 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0807346168;
        Thu, 23 Jun 2022 00:26:27 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id g26so17745587ejb.5;
        Thu, 23 Jun 2022 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YYyVPQjlw02cUE6QrdjvgizmIzVEdfA/6xpBxXMZBek=;
        b=Y3SxlHY+tiz7aE38RBYVk+Cr8BDWRw8M7uIiZXxZaWvnnbmubAg/3pv96V2d92AfKQ
         ZRYw/InmSz+2d99Q5Wx4alEHLjUeOIaRu6VAsZEuyEXfHdjbDHaS2wdccvqeA9shaCUx
         lMSM34twJTMISP43hb1bOVjqodlSq3uHgctHeGyLXdWujFq0UxYOPLhefVycTpKDo/nw
         JV6SWp0JAV7qGdaKor25mq1UJevgfqvwN4bzQBA8czKlnrfZRNwz/nh0OCsv/x+zzTWf
         ws5SZwd8jMJATAYB9TR1kV+2joi5/intOnfeeiUGCw903NK5hKunaoifj/VyEXLR0S8F
         b9Uw==
X-Gm-Message-State: AJIora/B8QmWfE1Ax6OIc9g0LNgCduqNWY4dXxEl5WR9oRnDh07rZjcR
        BwQsDPKhz/jgnmcceazxzjaBf5X+kLodgg==
X-Google-Smtp-Source: AGRyM1t6Q0TNmFt13xO4kAszmlZoKlkcyZ5fH0hrpz1evswOJLMpBZyEd4GS00Ke4rPLD6/1fBwVQQ==
X-Received: by 2002:a17:907:7283:b0:722:e541:f157 with SMTP id dt3-20020a170907728300b00722e541f157mr6862878ejc.269.1655969185609;
        Thu, 23 Jun 2022 00:26:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c25-20020aa7d619000000b0043574d27ddasm10956201edr.16.2022.06.23.00.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:26:25 -0700 (PDT)
Message-ID: <c6d86469-94e0-da4d-7b65-df166ef550ef@kernel.org>
Date:   Thu, 23 Jun 2022 09:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/6] serial: Use bits for
 UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-4-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> Instead of listing the bits for UART_LSR_BRK_ERROR_BITS and
> UART_MSR_ANY_DELTA in comment, use them to define instead.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
