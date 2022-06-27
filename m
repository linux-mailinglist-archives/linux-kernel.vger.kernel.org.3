Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724055D138
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiF0GrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiF0GrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:47:09 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB7559E;
        Sun, 26 Jun 2022 23:47:08 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id mf9so17130016ejb.0;
        Sun, 26 Jun 2022 23:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8HomK3l6jlBCLsSb7Jf/Zdvy1qIVhQIP50p0E/9QVR4=;
        b=xri4hn4QwepxsJgBIhMlrfAFME10UlnWrbYjE2wacXkpIchaZ+fFxIqxm5f5Lk7J21
         gQLVugIMwT7WzjFMFwDBzeEl9LaOZ153hGIay12DYGnxXdFgM3R54gW4lIFZJgqDl/9y
         kkGbjTm7rsYleXHMTZBzoPCGWU18Ks7qukLAcBeD9cOimxozFJF3CcpphoOvUEZd6aBy
         liqFLU7gASlCaRn8tXkCii1PsKptQz0inuVWNWlcnNxpHrg16J6JZwkP4oXmQSWzooZa
         YlijLvv/L696im+qHZ5f6kmwXGV/MP2xeNNTRsv2i0Cj1QE/QuNOJOQBsoNVyLeHhFgG
         qPaA==
X-Gm-Message-State: AJIora+z+/ZzrRnZEsvI4n6Ot4FTXfgSdDVV5Kxcjlw6rVAkGH9KewtO
        FIV8YzBxxDxHqDmYVv4Unz8=
X-Google-Smtp-Source: AGRyM1u96qvLjAc8rMt3uBD3ubW9adxW2CDbwcX2yO+evsWDo+MMjNDM2rv0uVldDi1BuxZYwlq3mw==
X-Received: by 2002:a17:906:dc8a:b0:724:d541:d324 with SMTP id cs10-20020a170906dc8a00b00724d541d324mr11096133ejc.377.1656312426841;
        Sun, 26 Jun 2022 23:47:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090648ca00b0070b8a467c82sm4648674ejt.22.2022.06.26.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:47:06 -0700 (PDT)
Message-ID: <ede0760a-75e4-4d53-256c-86ca5a19a5f8@kernel.org>
Date:   Mon, 27 Jun 2022 08:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/6] serial: Convert SERIAL_XMIT_SIZE to UART_XMIT_SIZE
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org
References: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
 <20220624205424.12686-6-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220624205424.12686-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 06. 22, 22:54, Ilpo Järvinen wrote:
> Both UART_XMIT_SIZE and SERIAL_XMIT_SIZE are defined. Make them all
> UART_XMIT_SIZE.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs
