Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499A5767FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGOUIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGOUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:08:41 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143AC00;
        Fri, 15 Jul 2022 13:08:38 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id c3so4605367pfb.13;
        Fri, 15 Jul 2022 13:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AGRZfVbKDyiQzk8+TdTbG4aad4bbLhDSN7hz43+l7UE=;
        b=6VSn9b4XyN/748PnJMPGFxSgeNv9MS0dm1j9YujQPAD85ufiaC8n3Z80A54EqHH23E
         RBcAgUzoKZJyFipGetDEo1jmd9dn3L39OWGEURsq8SVpK9xzi+8lhvKDzeK0HWl6ED7i
         eOyWIFx/jfU+jkDOxwtQgmpOj/3ddFFv0IOM2W2L9JzStf6IFNhkTTyQXgGiMDkNduOl
         YPcm0yvHmIM12HjYNvl41xZ45SzdxMJ+/83StjKcuCWXSQQ0DsDsb14WRCEThIgEi6bc
         9ZK4kF5LePrK4FJ3n+avFt/j9HLHEveFoYLc8hgY4b7zBDESI1xpqIQ3Bqea8bxRUvYn
         n53Q==
X-Gm-Message-State: AJIora/Fb3QeCR1J5w5wdR1tOvInqW0PuISi0rz2YpfWfoxpDCtnyR8G
        wPMZH4q/83yezB3uAWWQwZo=
X-Google-Smtp-Source: AGRyM1umbLYdghMK69WLQdua9gp4AenAs12BsoE/LQ+UvaPgrJJj8RSEf0Q+O/f+S//qWq3+xnEATw==
X-Received: by 2002:a63:4d4f:0:b0:412:a02e:2896 with SMTP id n15-20020a634d4f000000b00412a02e2896mr13996580pgl.337.1657915718110;
        Fri, 15 Jul 2022 13:08:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:276e:f777:f438:e01d? ([2620:15c:211:201:276e:f777:f438:e01d])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b0015ee60ef65bsm3978634pla.260.2022.07.15.13.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 13:08:37 -0700 (PDT)
Message-ID: <8919f85e-41d3-1fff-962a-9972064307d3@acm.org>
Date:   Fri, 15 Jul 2022 13:08:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Correct check for RESET DSM
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220715224722.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220715224722.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 05:48, Daniil Lunev wrote:
> +#define __INTEL_DSM_SUPPORTED(host, fn) \
> +	((fn) < 32 && (fn) >= 0 && ((host)->dsm_fns & (1 << (fn))))

Could this macro have been implemented as a function?

Should '1 << (fn)' perhaps be changed into '1u << (fn)'?

Thanks,

Bart.
