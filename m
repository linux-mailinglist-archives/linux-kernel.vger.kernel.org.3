Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E374F931D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiDHKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiDHKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194031E783
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47C561F1C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA9AC385A5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:33:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RKUKnxkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649414030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WM5P2Hai9yYc/eesrdT8rAu5l0kBRa/QDlTKJKZY1EA=;
        b=RKUKnxkIK17zikcfZpFX34An27TQpzFz5rn5X7fatwRthtn8eTaDw/dkSkx9ZVU74TmoGN
        O+VLgM6y+1dDcBbLFIRxIi6t7zMjfubdvoFUd0K+yZFEYa0Jt9Y4ko/xTKEioq+H+8AxcG
        HGmF26A3Tw26FtYjDtZLtlfoFT5sWaE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e5fa8121 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 8 Apr 2022 10:33:49 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id l36so14277650ybj.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:33:49 -0700 (PDT)
X-Gm-Message-State: AOAM530Lsf/6j3xPG2iF0W7SyYrjcF2cO4REQmY0efiSst9vqFciY4F4
        4ifvs/OkLc6Inx+w546q6sJ25wDdRppsd6CwIBU=
X-Google-Smtp-Source: ABdhPJxIOZN/gj4Ny1Z5HHNENQaeQselJ9UZhN/I9E6LZlTssdDCPcgENyIluxUK0RViC0LN1qMUKck+SOJLS6aeJmc=
X-Received: by 2002:a25:2517:0:b0:634:63cb:68fe with SMTP id
 l23-20020a252517000000b0063463cb68femr12823155ybl.271.1649414028545; Fri, 08
 Apr 2022 03:33:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:470c:b0:173:a80b:3ec5 with HTTP; Fri, 8 Apr 2022
 03:33:47 -0700 (PDT)
In-Reply-To: <8d652dac67754a308b270c453b3032d2@AcuMS.aculab.com>
References: <20220407193433.523299-1-Jason@zx2c4.com> <20220407233558.3369-1-Jason@zx2c4.com>
 <8d652dac67754a308b270c453b3032d2@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 8 Apr 2022 12:33:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9qZ4HjG_qL2qb=bUn95rUmd_F8bUnzD=Ht2MMAjuH0CFg@mail.gmail.com>
Message-ID: <CAHmME9qZ4HjG_qL2qb=bUn95rUmd_F8bUnzD=Ht2MMAjuH0CFg@mail.gmail.com>
Subject: Re: [PATCH v2] random: allow partial reads if later user copies fail
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "sultan@kerneltoast.com" <sultan@kerneltoast.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 4/8/22, David Laight <David.Laight@aculab.com> wrote:
> From: Jason A. Donenfeld
>> Sent: 08 April 2022 00:36
>>
>> Rather than failing entirely if a copy_to_user() fails at some point,
>> instead we should return a partial read for the amount that succeeded
>> prior, unless none succeeded at all, in which case we return -EFAULT as
>> before.
>
> I think you now return -EFAULT for a zero length read.

The diff context doesn't show it, but the first line of the function
is `if (!nbytes) return 0;`, before various other bits of work are
done.

Jason
