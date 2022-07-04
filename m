Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C407564BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiGDDAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiGDDAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:00:13 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1192AE0;
        Sun,  3 Jul 2022 20:00:09 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso2002542pjb.1;
        Sun, 03 Jul 2022 20:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vUcbLJ2czRHbyfDNPBsrrILdDcjbc2rXHAhbpDQ5bYs=;
        b=XQ41I2IiTDZN3N+jbM36dEWiwUKXNMAxxspdo1htsRGz3Vjvp/JHGtDrwZtY/gA6Xs
         Ya4P9143RFd6+bLDMfnhTkQFIF5WS1+8OiLalEmjiyU1yEcHkbBjqNdf3DPuXLc76LFJ
         vuzbwrayjc6vCGz8PHVzPlqpsvOI7w+5TZzM+zAM93xiCkE/ioorHFaPCe9plFgAtsfD
         cOAXfNgdosQah4kMHh33I6mUEvZeR+uTYVyuIETUOCqcmf/iiAz9rASwhCPrw4D6/tvu
         wlMWSaJaayIXWDmkhLAzqe47Dr/N3qZV5TH95XUkpZJ7truNlXxIwRxe3einGsoH4/zQ
         I3sA==
X-Gm-Message-State: AJIora8Xx9hCCBY8T/fkhGwnv5lKCaB17rtk9a5RFERKd1kp873swQtX
        CT8kaj1UgqGN/d/fQhUd1LA=
X-Google-Smtp-Source: AGRyM1uYMEaEW3aD/B2kamDHroheVFY21M36FgTMBUzUWg+pdK9QTKJN2jxkZMvP+zBn2fmLApLbpg==
X-Received: by 2002:a17:902:c641:b0:16b:dd82:c04 with SMTP id s1-20020a170902c64100b0016bdd820c04mr5632067pls.144.1656903608965;
        Sun, 03 Jul 2022 20:00:08 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0051c1b445094sm19978953pfj.7.2022.07.03.20.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 20:00:08 -0700 (PDT)
Message-ID: <fd3bb4b5-0a19-2dc0-c4b5-60f32abce508@acm.org>
Date:   Sun, 3 Jul 2022 20:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Enable WriteBooster capability on ADL
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220704092721.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220704092721.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/3/22 16:28, Daniil Lunev wrote:
> Sets the WrtieBooster capability flag when ADL's UFS controller is used.
            ^^^^^^^^^^^^
WriteBooster?

Otherwise this patch looks fine to me.

Thanks,

Bart.
