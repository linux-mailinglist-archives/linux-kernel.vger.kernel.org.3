Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55174F6047
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiDFNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiDFNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:50:34 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7C3A0B0B;
        Wed,  6 Apr 2022 04:21:13 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id n6so3489253ejc.13;
        Wed, 06 Apr 2022 04:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/E0Zaul7G+qNTtOYXrVNpVo8Eq1Tbjxqas5afyEvmXI=;
        b=yhuO5+SRgpDRwX5XpK+wz6mYJAs3ktm171XsBX2IdjaJ/Qhx9JRVMMeXfh2WLxGy2V
         uMYlS9L8Y49qv8NzErQKnzYZiKEweLHEaVLc8jc8HjhyS+pggIaM48fS/sqsJrc/yNcV
         3a7rRI+yuUysS3eifAJADvPO7xfe6gjYCWTMx/41y1zidM9tihLrWh7kCZbuaZZE3Qdu
         5zw5MqH9AluuMQg31k+6OXu06Yz5pPu4+VcPyWnqg3/75zvzq2CzbJrfFKBnGFRowugm
         iZc8E/QiDV3cGtfdxQjGaE4Tioj21v3qsBrbTsGrBQfHNIFt6ymoU4v1IvtkR6wVdPQ3
         idNw==
X-Gm-Message-State: AOAM533VyLwOPLN4bbwIyrytpcAS1mgTJ/jXt31+kVFrUN/DqH82gcfB
        2hxtxWTQJOIImJf6rWdXonETwhgiT9A=
X-Google-Smtp-Source: ABdhPJy+w5JmZ7zlbPP+sjHY4UMYaCYUyg3o2G7jpLBB1TEr0Ibp/apvXaDINUgn8UNLSXKd06L8vA==
X-Received: by 2002:a17:907:3fa6:b0:6e0:dac6:79d8 with SMTP id hr38-20020a1709073fa600b006e0dac679d8mr7654128ejc.86.1649244071612;
        Wed, 06 Apr 2022 04:21:11 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k12-20020a170906a38c00b006e7ddaa89absm3963325ejz.52.2022.04.06.04.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:21:11 -0700 (PDT)
Message-ID: <42d9cf5d-2e08-51e4-a3f1-9bd856223a6a@kernel.org>
Date:   Wed, 6 Apr 2022 13:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt and
 console_write
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'Chanho Park' <chanho61.park@samsung.com>
References: <20220406082216.11206-1-jaewon02.kim@samsung.com>
 <CGME20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f@epcas2p2.samsung.com>
 <20220406082216.11206-2-jaewon02.kim@samsung.com>
 <Yk1NmTdUgMcSIq1O@kroah.com> <042701d84991$ca50d410$5ef27c30$@samsung.com>
 <98c359ba-9563-3da0-d968-ae40cee9d45f@kernel.org>
 <004401d849a8$30b87d00$92297700$@samsung.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <004401d849a8$30b87d00$92297700$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 04. 22, 13:19, Jaewon Kim wrote:
> Okay, Thanks to review.
> I will fix 1 to bool in next v3 patch.

(And 0 to false.)

-- 
js
suse labs
