Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962F54C2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiFOHiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiFOHiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:38:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80E2FFD6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29EB2B81C77
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F388C34115;
        Wed, 15 Jun 2022 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655278684;
        bh=pnJOadH0YoVYYLx7ob0PUxPv2n/UnPgyF8EolnCZrbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvOGNKRRwXhGy2FvnDnMyyiJiDF8bAs6H34OrzJlqLwvtNizOdtmDrEs09uRlG1+t
         NtdGkOxBtCfc1q7/7FKQ8AeyKzIwID/6CkjxKgN2le0Gd01dtDo57qiUdCr7PfrvWF
         jnEMGPHkHFCq4/+V+hF21ZtjN5r3wbFOlDLV2l+y5k7mIM5ahtcEWAfmvgm5TUWAKS
         8HQUDnR8ZeEjdzzjMyMsPBEXK6+gn0M1AVzHRJS2b4U9zPjnCmk+gY6JVw6zYoUE+5
         aN5Wf0f92EEgFpIswA50vKygBlA3kzt3L7zlub5AMLYYnyy6ZRuC/DtpAO4clfqIBp
         w77byS+JdT4Mw==
Date:   Wed, 15 Jun 2022 09:37:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
Message-ID: <20220615073759.ps63einipnptgpnk@wittgenstein>
References: <20220613060723.197407-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613060723.197407-1-avagin@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 11:07:22PM -0700, Andrei Vagin wrote:
> Right now, a new process can't be forked in another time namespace
> if it shares mm with its parent. It is prohibited, because each time
> namespace has its own vvar page that is mapped into a process address
> space.
> 
> When a process calls exec, it gets a new mm and so it could be "legal"
> to switch time namespace in that case. This was not implemented and
> now if we want to do this, we need to add another clone flag to not
> break backward compatibility.
> 
> We don't have any user requests to switch times on exec except the
> vfork+exec combination, so there is no reason to add a new clone flag.
> As for vfork+exec, this should be safe to allow switching timens with
> the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
> if a child is forked into another time namespace. With this change,
> vfork creates a new process in parent's timens, and the following exec
> does the actual switch to the target time namespace.
> 
> Suggested-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---

Looks good,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
