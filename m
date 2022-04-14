Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108DD500C25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbiDNL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiDNL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:29:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A76C1C4;
        Thu, 14 Apr 2022 04:27:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b15so4578064pfm.5;
        Thu, 14 Apr 2022 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1+CoCJrXT14J2VO1tmxeljnPM+sDWGv+iuU5ZAwlMMU=;
        b=e1K35ZzbeO7sxfFRYtgg0inrZZjUHpWGicmshbnDK7ns9PPX+lP06jf3Om7NR7EKE0
         dMXHWgFz4Av5Bi+w7uRAFtZoohtO9mmUoTFt5/xCQy+MYTO37SasRJ+6hoOtyxLjL16A
         dTYHQ5+U7No3QMX0zFNzs+aJsIVB+z7Yosve0O81fzXBk1qQdk6T4BrIIhJe67dFARQS
         Kr5k6GNcsvUaf1iPxIsYNa4GZf78Mjd23ntIndnoXGPk/Dr8Fi5iupNUPFZlUv+mij4T
         8DwZt9D7Xc8Rpj9OdMyonzZszka+fF27fkCr4X6B2My9kOkBSIlmmTzSKo3dghFwZg/5
         FKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1+CoCJrXT14J2VO1tmxeljnPM+sDWGv+iuU5ZAwlMMU=;
        b=buaAY46GtMUR34pq03u8qYz3pUPagftzdCt8zEVvFD5FSdiUNTcEt9SinyIrb0GvGC
         GWdwH2jO+2r4Zi9MK3ynL32zYKuw4+U/nuZgFikPL2UV1GLHhSKDY02F2BPpvX4NJiGp
         m4BAyfT1yzB3/LJQqT4POzvM6gQEiBKEodFsTP0y07LcdeesDo/157mHbkOPZk2RlVwE
         iCO3SWtWXd0MF28olW+IrrAEYna4+EOTAurSizSg4U40y7Lv2NbFjPiirs6C9fACLmhV
         ru1y3ueOO8CugS2puzxg1Rh2DCB3wpuFTkiKAbc8BYDS5UexpEzTooah+R3mgiy0k3DS
         ok+Q==
X-Gm-Message-State: AOAM533h2wc3Bp9CdUG+pCjqauBu3NEd865PxkhLIfQkjUL63GR755nX
        hgUoufbbMff/W7EwPifkjWg=
X-Google-Smtp-Source: ABdhPJy56GHcI9ZrtvDdcR1S0e9V/P54WAMm6U80IxoScBoYaOttE2ZRCtR/eWM0qXtMQts2mMg5Cw==
X-Received: by 2002:a65:418b:0:b0:382:250b:4dda with SMTP id a11-20020a65418b000000b00382250b4ddamr1972051pgq.428.1649935633119;
        Thu, 14 Apr 2022 04:27:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm2134741pfj.146.2022.04.14.04.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 04:27:12 -0700 (PDT)
Message-ID: <0dd9ba0e-712a-37f6-a50d-f5510cd23033@gmail.com>
Date:   Thu, 14 Apr 2022 18:27:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/3] tracing: Add documentation for trace clock tai
Content-Language: en-US
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-4-kurt@linutronix.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220414091805.89667-4-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 16:18, Kurt Kanzenbach wrote:
> +	tai:
> +		This is the tai clock (CLOCK_TAI) and is derived from the wall-
> +		clock time. However, this clock does not experience
> +		discontinuities and backwards jumps caused by NTP inserting leap
> +		seconds. Since the clock access is designed for use in tracing,
> +		side effects are possible. The clock access may yield wrong
> +		readouts in case the internal TAI offset is updated e.g., caused
> +		by setting the system time or using adjtimex() with an offset.
> +		These effects are rare and post processing should be able to
> +		handle them. See comments in the ktime_get_tai_fast_ns()
> +		function for more information.
> +

In what file are the ktime_get_tai_fast_ns() comments?

-- 
An old man doll... just what I always wanted! - Clara
