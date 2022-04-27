Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CE512009
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiD0RmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbiD0RmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:42:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1423424AC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:38:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651081121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xHL4QmCK/DrOa/aJvmZpkDiXv/J3Ez+2YZAF0qtmas=;
        b=JKIwAvejtrpZqcRMRvzCcPLDjD9jpC9Id6pPNkwbhcLd+gvStTTf0pRYXL3eD2jL2yOVOW
        N+3Xm0DLVCdPcNzSLsODfmvJWZqzUxc1hoH3CH86zoSZKKPaWfK26En2fmSWYcQRkYWq2D
        FayvHmQ0wCFHP50rfSY9bFxapX7y6ff1b7YTbLr4Mh0omcnnOAyrYPc2y7jZ5OQxuTqKr6
        KSiPrpJLIc8qM+hQIG453Qt9PcJjoUgzzCsY62L0zSYZjMZD/+tpPevEJxktVE4cAhMJQG
        tFx6Nmfb0ShSME5a3PE9SdnEmd3Rw2y8Wy+KCMmW+wuzCqKIztclGF7Td4S5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651081121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xHL4QmCK/DrOa/aJvmZpkDiXv/J3Ez+2YZAF0qtmas=;
        b=pNY2gPs31YerENxCnWjlEiR0Hps/y0tPmMorvNqnJr7gcp6vd29WSki6eQ0jyou5MshSK9
        DC8yGIzsqK+KBZAg==
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] bus: fsl-mc-msi: fix MSI descriptor mutex lock for
 msi_first_desc()
In-Reply-To: <20220427103846.hjnkfn5fpuqlzuap@shindev>
References: <20220412075636.755454-1-shinichiro.kawasaki@wdc.com>
 <20220427103846.hjnkfn5fpuqlzuap@shindev>
Date:   Wed, 27 Apr 2022 19:38:40 +0200
Message-ID: <87sfpywhnj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27 2022 at 10:38, Shinichiro Kawasaki wrote:
> On Apr 12, 2022 / 16:56, Shin'ichiro Kawasaki wrote:
>> Commit e8604b1447b4 ("bus: fsl-mc-msi: Simplify MSI descriptor
>> handling") introduced a call to the helper function msi_first_desc(),
>> which needs MSI descriptor mutex lock before call. However, the required
>> mutex lock was not added. This resulted in lockdep assert WARNING [1].
>> Fix this by adding the mutex lock and unlock around the function call.
>
> This is a gentle reminder. Comments or merge to upstream will be appreciated.

I expected it to go through the FSL tree. I pick it up now.

Thanks,

        tglx
