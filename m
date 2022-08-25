Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803995A1512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbiHYPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiHYPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:02:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365FB6D04;
        Thu, 25 Aug 2022 08:02:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so5235268pjn.2;
        Thu, 25 Aug 2022 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=zutck/R4vqfMAc9Va/gxGNWESNQWNEXtjaZOSwVGyI0=;
        b=BxEAB+ML6Cs3qV3m80uUvlOwixZb3aVojqiTwiuDpdcH4iLVZHpRDW8VD0/fbXaN8m
         dx+ha4FpP7cZtUuGloMebxSEaD04mQTWBMcPF4c/sL8fRjEhmtjmx//rA8dN6lXSV1lb
         FqoQRSUMxiptTtm56midQKAiyL31CnTW8mZzKlpMn3LqVEdC2fxhwHdFrsIPipPYDDZO
         18sPeffUwM7PZrSK/v9C0umdLj5GMgZnlFzz5NVCaDpussYxnvHhYARWE5w0qdMFSUGc
         FS7HFwyVUcejcH2hk09n73mtL/UdvTyOpH3kXiFcAzxVbWL6fyo1jwfqW6oVNE0zuTzG
         k+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=zutck/R4vqfMAc9Va/gxGNWESNQWNEXtjaZOSwVGyI0=;
        b=V+buGC1+l20ur0m3nSfOEZxlYo36DEnVjq4URcgVSecfjWxVSXuLQlFiPIUeUu0Ar5
         cKr1s0jhps7aZMgKQ9KJIIins3LOLw5W+1JgewDmqQou7O5Pr1f8qIUC/JEJswstyA3+
         WEKSliv+pSHj+NybO5YPAPa+gxoGM3djRJN32n0HGv6Ktxt3CMIsGelDquH1I0L2LmBx
         pAMQcgONdbS8hmAwNIWToZbpBS9I5b7+K+wn5GolyS4fpwXu4aVB3i1j3239cQgzQKO7
         MM3gbH4QGcQD6sYZEQEnLV+GDgCbQpRWiePxPmOZ+uRUudOIm1l26F+gd2pd5+r+WEGr
         mTLA==
X-Gm-Message-State: ACgBeo1lwB2k0dZFBcctB9BWFosBes2K9xjgZ9mskajc2DtpQvxPuStO
        2Eq+AI0pdvdw0VYZYrL6KVMulxM0MpY=
X-Google-Smtp-Source: AA6agR5Ya9hfbu7fsJXYg/tRtDApX1RWXNjmeinDvxDjm0BIfpCQfVwdvDffF+wmBD0SjmKJ6Gcdkw==
X-Received: by 2002:a17:90b:3144:b0:1f5:829e:cd49 with SMTP id ip4-20020a17090b314400b001f5829ecd49mr14601038pjb.80.1661439757721;
        Thu, 25 Aug 2022 08:02:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c127-20020a621c85000000b0052ddaffbcc1sm15233869pfc.30.2022.08.25.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:02:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 Aug 2022 08:02:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for
 tps23861
Message-ID: <20220825150236.GB240395@roeck-us.net>
References: <20220825143737.77732-1-dev@aboehler.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825143737.77732-1-dev@aboehler.at>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:37:36PM +0200, Andreas Böhler wrote:
> The tps23861 driver does not initialize the chip and relies on it being
> in auto-mode by default. On some devices, these controllers default to
> OFF-Mode and hence cannot be used at all.
> 
> This brings minimal support for initializing the controller in a user-
> defined mode.
> 
> Signed-off-by: Andreas Böhler <dev@aboehler.at>

nack for the series, sorry. The suggested properties are not hardware
monitoring but phy properties. There should be a separate phy driver
to manage those.

Also, as mentioned, the hwmon 'enable' attribute is abused to control
port functionality and should be removed.

Guenter
