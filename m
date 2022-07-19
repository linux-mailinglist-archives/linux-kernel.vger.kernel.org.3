Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74E57A644
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiGSSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbiGSSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:13:57 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B55C969;
        Tue, 19 Jul 2022 11:13:57 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id f65so14186832pgc.12;
        Tue, 19 Jul 2022 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F/KKkQ8KjpEzJ0wiPc9e4uFQ2dA+K+enxTSy49Vbo3g=;
        b=czYnzklfTs+lfBh2yd3s43viPuD/RwdyY1gzgJG9oSQG4LhOhmKYoienk8Esp4vWbO
         /rMqBQbtlJ53zHuTPO4bjgA95QJY5Dh2KBKnYJuHC9+U03TzXNV+NfAI9zSG/iD7Ccvb
         AdQihVC4Wm4PYCACItHJF97kKYmJe+BXZqDf91hleNl6lCVhal6LmZqkhWUYnl20gj1w
         0gVD75oX5C/8UGhPaZd8S2PudXxC83Pwr1n9nJPimqVjU4NsoHbb+J1LFIlEEUBOH16e
         pBN3sZi9GMzEzXnsnzj0TwILiE9cUXPxFg8B6sl4yQeCVaEKiIXkZ5Tll21UGw9Wu4PH
         C3kQ==
X-Gm-Message-State: AJIora/M0pQrIRWJTOOqYSLIy+ijRWgVz6kSVqxsDHYgxe5CKz7gRrqg
        ZEEUZzRD3b0cet/XKpgK87Y=
X-Google-Smtp-Source: AGRyM1s9r/8L9TvwAnMnVwIPiB8MCLIOASkPjKxdcUCT6ckUpJYzlD00OJ1tWgnVNbQC9P6ZaR5A8A==
X-Received: by 2002:a65:5b8e:0:b0:41a:3c3:b693 with SMTP id i14-20020a655b8e000000b0041a03c3b693mr14168011pgr.84.1658254436321;
        Tue, 19 Jul 2022 11:13:56 -0700 (PDT)
Received: from ?IPV6:2600:1010:b002:e126:5611:6026:69c2:37bc? ([2600:1010:b002:e126:5611:6026:69c2:37bc])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016c500fb7bcsm6020464pln.140.2022.07.19.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:13:55 -0700 (PDT)
Message-ID: <a0a97a0e-3a09-2162-243c-b85008eb725d@acm.org>
Date:   Tue, 19 Jul 2022 11:13:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Correct check for RESET DSM
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220719101903.v2.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220719101903.v2.1.I22460c4f4a9ccf2c96c3f9bb392b409926d80b2f@changeid>
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

On 7/18/22 17:19, Daniil Lunev wrote:
> dsm_fns is a bitmap, and it is 0-indexed according to the check in
> __intel_dsm funciton. But common initialization was checking it as if it
> was 1-indexed. The CL corrects the discrepancy. This change won't break
> any existing calls to the function, since before the change both bits 0
> and 1 were checked and needed to be set.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
