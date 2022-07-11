Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D35708BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiGKRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:17:11 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6A5140F;
        Mon, 11 Jul 2022 10:17:10 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id b8so3970806pjo.5;
        Mon, 11 Jul 2022 10:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qSFkKSsB61cSencPZX5e8kmY/fgnez67OIo3PXDb/O8=;
        b=OTpleX6JvLOW+HydlWQ5aGg3m8fPDvwBR4N04yV7uoeLdfy77T4NMdu6Cak5iAVh7G
         t1KeLwVF+WPxs7jWDtaP2evVjXQlSAe9lGOTxI0e9lCRmexj+ZTLTB++r14PkLdp7DIW
         SencLGR25B8p3on1REEYpdM0jQtBTo+O/+kN8ftaWi68jLYfJ3rH3kxar78b3Aa0kgHD
         n7y4dbt6sfrjTr20I73jgTl79E0BK/n7KqfwHHfhcJAomQfXmMeP1eCndQHfmKXony7q
         aLxsg0N1UJrE8U5hvFmYxdTYqd/AhCzuuJiH/zjf2qg05/55Yry2acn0s4Ryd99xqPeK
         VwwQ==
X-Gm-Message-State: AJIora80Z91s38tjqSJPynn53QeFYugMgBSm4YWPzxYiAyszQ3OPjM4p
        ZUPmycv+W9ErUBQrfRgFDnI=
X-Google-Smtp-Source: AGRyM1vTWWIhdhxc86vQkxgnZb04W+HRgqmSHxh7cnXsSMnOb9PJSuvMZgj5M8eYDCdY3nEB9iyA+Q==
X-Received: by 2002:a17:902:c7d5:b0:16b:ea78:4eb4 with SMTP id r21-20020a170902c7d500b0016bea784eb4mr19399565pla.65.1657559830453;
        Mon, 11 Jul 2022 10:17:10 -0700 (PDT)
Received: from [172.16.225.97] ([99.0.87.44])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a0000cb00b0052974b651b9sm5042485pfj.38.2022.07.11.10.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:17:09 -0700 (PDT)
Message-ID: <317c8196-0e79-7b1d-cc78-64dfb9f7ca8e@acm.org>
Date:   Mon, 11 Jul 2022 10:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] scsi: ufs: fix missing clk change notification on
 host reset
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, asutoshd@codeaurora.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        mason.zhang@mediatek.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220711144224.17916-1-powen.kao@mediatek.com>
 <20220711144224.17916-2-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220711144224.17916-2-powen.kao@mediatek.com>
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

On 7/11/22 07:42, Po-Wen Kao wrote:
> In ufshcd_host_reset_and_restore(), ufshcd_set_clk_freq() is called
> to scale clk rate. However, this did not call vops->clk_scale_notify()
> to inform platform driver of clk change.
> 
> We propose to call on ufshcd_scale_clks() instead so that clk change
> can be properly handled.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
