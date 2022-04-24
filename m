Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3750CE47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 03:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiDXBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 21:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDXBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 21:52:58 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894463C4;
        Sat, 23 Apr 2022 18:49:58 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e5c42b6e31so12624711fac.12;
        Sat, 23 Apr 2022 18:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HdDCdJEingdj1BtxscgnBzWm9IeD9qwg7IBZsost16s=;
        b=l42kw1gmYnAvUPgiz1we0vABR4tN8Zmq+6LT2lVFvUZwiencbyxIPsPUTfzm8brEyN
         QJnTepcCXLlb8Sc5jkPjLxGhz5xSuEg/vMimqD3Z46kDEiMjpDx80BW2Aqaot/O/BPqv
         83aJ65IuS/R2L/f5Ek7FnQWFg7BSeQuPT2D1WmQcooBBb7llBsVYXtTmzejOVwoDpykx
         vj3OEAYKaX6GujKsELOg3of9FIQcdoNTCM0XrqF7wuTBF9OOK7eKhQbT2Qaxj050bHkw
         nChC5pjZxnLUQ1i31E4QQfLQ9NE12D55L9QLJQF7k5+xQx8HcVsmTISQC19ljud3dMOM
         8F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HdDCdJEingdj1BtxscgnBzWm9IeD9qwg7IBZsost16s=;
        b=xGssTY2xBezH7yFR8ko72s8OqOBrTcqRp2nMkf6lNqfpFqShESCPv0MIAI1wke31Od
         SNJv1GG7DRKXRIRmA2h4pfD8hG74OajSUoYW62i25S9Fo5zuZVZIcySCmc/HtY8l0e2E
         kHpUK4typ8yIKkGHsmWxCBX+HCRAob1Va0d4diaPGyzLuEnw3r2L2ZJZE/VQiYrROjZD
         HH2Gmag0x+lfkH+seZ5P+2Sq/bwAK0j41fBRufsN1H2/jsiGrldV1hZvxvMv7zTEv1p5
         o3E00bi//YbmVKv8EU41PGEl1+BqSRWZQUOeEgXgvyqVmmBUl3x84X0BmWlW2KYaQvY1
         V8BA==
X-Gm-Message-State: AOAM5326Kt+KyAjFeggamczfdwMBz6gHPZxHszS3QQlu57Lw89MLXjKm
        06q9coQKRZQGmNYLzEVoF/Q=
X-Google-Smtp-Source: ABdhPJxoSktaRJuA7Ko1CKr2jk8aTGRq/jGF5WkEiuhuaz9dXl92zUa4hbph21RqLF7wZY/67YOOlw==
X-Received: by 2002:a05:6870:738c:b0:e9:155e:7f40 with SMTP id z12-20020a056870738c00b000e9155e7f40mr2034120oam.124.1650764998232;
        Sat, 23 Apr 2022 18:49:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lf13-20020a0568700c4d00b000e9254af871sm505374oab.49.2022.04.23.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 18:49:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 18:49:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add cooling device support
Message-ID: <20220424014956.GA3989878@roeck-us.net>
References: <20220410163935.7840-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410163935.7840-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 06:39:35PM +0200, Armin Wolf wrote:
> Until now, only the temperature sensors where exported thru
> the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
> to make them available as cooling devices.
> Also update Documentation and fix a minor issue with the alphabetic
> ordering of the includes.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter
