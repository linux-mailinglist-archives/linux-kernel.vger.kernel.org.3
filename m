Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB474CA05C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiCBJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiCBJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:10:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A35BB095
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:09:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B4C91F37E;
        Wed,  2 Mar 2022 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646212187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81XLZdJTxsdo7/bRz3kjmDMEOLKe7jESLpZCe4VnvqE=;
        b=k8yt4iAjrQQOy+X00UrbEW9jP81lB3Iz7a2gsj07TWUjIeTK6th5Ipx+rL3GpjzUuFmNTv
        C/sUk98K6kJq7EEBDTycvBNL1C1f+0pH5g1q7/KpFHaRKvdGd0AbW6c1q9mvNY9U+yHDX1
        VunrrQBvhA61XEsVXfyBF/2emNDG+SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646212187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81XLZdJTxsdo7/bRz3kjmDMEOLKe7jESLpZCe4VnvqE=;
        b=O5TZ4vyelRYzLxvybbc1EJqpJc5z5JYo9vkXbIgG6evYkD5ZwkPuwNJCuM2yRLsuxbKvMv
        cXZFecWBVm87V1DA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC2FEA3B83;
        Wed,  2 Mar 2022 09:09:46 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:09:46 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Zong Cao <cz18811105578@gmail.com>
cc:     jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org,
        bp@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix memory leak in objtool_create_backup
In-Reply-To: <20220301163651.50346-1-cz18811105578@gmail.com>
Message-ID: <alpine.LSU.2.21.2203021008340.5895@pobox.suse.cz>
References: <20220301163651.50346-1-cz18811105578@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2 Mar 2022, cz18811105578@gmail.com wrote:

> From: Zong Cao <cz18811105578@gmail.com>
> 
> The error handling branch did not properly free the memory before
> return, which would cause memory leak.

yes, but objtool exits immediately in those cases so this is not really 
needed in the end.

Regards
Miroslav
