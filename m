Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2E4857F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbiAESJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:09:49 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10CC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:09:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t23so144266oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oxp1dnAx7p9DYOl98ZnSPxRU0b5qEUGHEusACTvziFs=;
        b=8XGjFISVzC7ZnNmnPd7+gjn8O65PKPZyMsylZMLEsPeA9yuyhyMb0OH7O3eRGl2RoV
         oBftKINJpS4V+0OPEaKjCJ9cw9JdPAE8Z00I7SIBtF/3UphM9Pjpy6t7aiLlAMtQJwjS
         hlRGHWnKkzqJRrjPhNYMujuj/gWaxGpF9KGNUuTV98lIj0KfiyC/9tHbfhu97aX2wdIj
         zHBU99oS4/ySFa/Y7GW6Ha2yKY9NfUSx0Gg+bEitbSyUpgYXzlRiS9REbNcQKc84wKvu
         G+kwyzbEE6+sJWHkuxi8eTAFaQn0s0sgJZOrqupUvtCxK6Pl614/W704mYRWacP1qBDD
         p3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxp1dnAx7p9DYOl98ZnSPxRU0b5qEUGHEusACTvziFs=;
        b=MHiAhxoxUQnYKixtNYO0t15Wm06yMfb//+kPYZCZqRNHC97QiUqzBbx47V1FRlVWvk
         UU+QBhMcPquqh5T3nieeoDLX+EzJcnwIt/8glpQX8TOti8wAxsyai694txLOcPdMWiQu
         m3gE17JGOg35mkcdYYja0QsBJgGsTBqezKIEaiyQSN8bmekCqMvdzei3Jph9BWNnaSSd
         FLrQ+ZnztzZ//UqZkz67yk9KlIw4vz8rDT6WbsmD9nyXvw+nO4OJbMk6GfLgyy1JgjAs
         hff8lLJkY6hlSQYMUjCjJVEGCqYDTK5k3Wvv5ShKXAf2el7WIhHaSjlodDWtN+XHXPa9
         GaQQ==
X-Gm-Message-State: AOAM531JelPEvPMs6rwtMvI+L1pZaIR3r8GAYLp8fLcgLmZt77xTP9Jg
        VFBSPbV8YBL0GxJZzVr/OdQ0PA==
X-Google-Smtp-Source: ABdhPJyRzxosjo9cuegGXGAeq/Xgxh22F6q0OwYTkGPqLqb14ekHqVR1VniMm8ezI7m+vOqJkJgOIA==
X-Received: by 2002:aca:907:: with SMTP id 7mr3641898oij.128.1641406188741;
        Wed, 05 Jan 2022 10:09:48 -0800 (PST)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id u14sm8746763ote.62.2022.01.05.10.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:09:48 -0800 (PST)
Subject: Re: [PATCH] sh: sq: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <20220104162240.1309639-1-gregkh@linuxfoundation.org>
 <4622e641-1423-e72a-4f6d-5f2cc747a148@landley.net>
 <YdXa7y+3seYoV85z@kroah.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <616fabc9-cf79-4c84-a1cc-6ecede77fa9c@landley.net>
Date:   Wed, 5 Jan 2022 12:11:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdXa7y+3seYoV85z@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 11:52 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 11:46:28AM -0600, Rob Landley wrote:
>> On 1/4/22 10:22 AM, Greg Kroah-Hartman wrote:
>> > There are currently 2 ways to create a set of sysfs files for a
>> > kobj_type, through the default_attrs field, and the default_groups
>> > field.  Move the sh sq sysfs code to use default_groups field which has
>> > been the preferred way since aa30f47cf666 ("kobject: Add support for
>> > default attribute groups to kobj_type") so that we can soon get rid of
>> > the obsolete default_attrs field.
>> 
>> Let's see, sh4-specific, depends on CONFIG_SH_STORE_QUEUES... it built but I'm
>> not finding an "sq" entry under /proc. (Or anything with "mapping" in it...)
>> 
>> Oh well, probably right? Didn't break anything for me:
>> 
>> Tested-by: Rob Landley <rob@landley.net>
> 
> Thanks!  Seems to pass 0-day testing as well :)
> 
> Should I take this in my tree?

Yes please.

Rob
