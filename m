Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5314AACE5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381044AbiBEWjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 17:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiBEWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 17:39:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262EC061353;
        Sat,  5 Feb 2022 14:39:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k1so1467453wrd.8;
        Sat, 05 Feb 2022 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=j7rn6ejWMJ/DEvj0EOgEa5CEFwEnLuvn5VmnsNIRLAE=;
        b=hR6melcPlEcsLk3aOxZEXgpNMQ7HUMCRq3xfs4oGwartiYiGt9Iayks3ASokcTMcxM
         cuzMCofcbwg+aD9JGpDqTiHx4pqW2zWy93nUNDa5ahhl5Z15LX/v1yOdZWX1P6qwG4Cy
         uu2AAjUm/XNiofos0P146N4QQu2+qLIqJ//EP6hDgN5V/VGOxpKbVC6EAC/GE6JhN6b/
         cy9rGZvxrsMiRpVAAOR8MBXDNF6LHbHKf0ra1W9WztRzpC64g4dqZNoXQqmg7mkJGvQ1
         obkH5rpWMgY/nRIdf6iDPQWX0JN4EL4JiX4wMqGMvgrry9A3INyTcTgbt4CUdNTO1cdI
         dWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=j7rn6ejWMJ/DEvj0EOgEa5CEFwEnLuvn5VmnsNIRLAE=;
        b=kiao+IAd/YUAFeDiOztmVNPCXliV3sQjONzaPzkQ7O8YSAvwiDqQuQdes5Bf9674hp
         V5VP5IxwQFyhflrFJ1n2431x1n91Ww41XuyxAv1voQDP0GugRnMt4xAPEn3A/wJLbCFt
         0mbVNt8stxaZadSXx4OsLcsjWast32heT71hSIbdGeaSK0c/QKwYnOXYIgWV2DHMGhBK
         s8VHn403azXFE8Rn9Y3VR5BC7461CTHlHMvSb/gFjX+Waks6UzSjD+G2etHdP7Dmy1tK
         uQdA1B98MQ3izPKYamUs1L+ZJSjSIva5Kt1JugZPObsGXrAfpXCiBu8m+uH8pUW9qig4
         Ycrg==
X-Gm-Message-State: AOAM533ZOFKNHSALLogDmu3DtoH8EnkIp+0fBf+2wxHvRibQsLeZHJ8p
        cNw/jxn6Er7ca8dlPeNCza/5sPzWd2A=
X-Google-Smtp-Source: ABdhPJzcTN4FcemXo1iPTo9xFK7SlFKZzdvc3hMIUaMJV0s9QyjYMdQJBH7jGSvaMBZIkCGuWcxatg==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr4263943wri.589.1644100791377;
        Sat, 05 Feb 2022 14:39:51 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o21sm4808255wmh.36.2022.02.05.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 14:39:51 -0800 (PST)
Date:   Sat, 5 Feb 2022 23:39:45 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Subject: [RFC] scripts: kernel-doc: Major kernel-doc rework
Message-ID: <20220205233945.7a4d22d8@fuji.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in fact a release notification of a major kernel-doc script
refurbishment I have done. My work has reached a stage, which can be
considered a world sync point and here we are.

I'm not sending all the patches to the Linux mailing list, as I prefer
to check what you think before I emit about 500 emails.

I've parked the lot for you to inspect here:
https://salsa.debian.org/guest/kernel-doc

This also helps me report the bug fixes. See the issue tracker:
https://salsa.debian.org/guest/kernel-doc/-/issues

A FEW PRACTICAL WORDS

Before I move on, I'd like to ask you for support. I can't find a job -
neither as a junior, nor even part time. So if you find my effort
valuable and are able to, send me some Dollars, Euro or other Yen or
Ruble to my PayPal account linked with:

tomasz.warniello@gmail.com

If you have a job offer for me, the address stays the same. I consider
myself a general Linux assistant, in case you wonder.

Thank you.

BASIC INFO

The main area of my rework's focus is modularisation. The leading theme
is getting rid of the globals. In the meantime, smaller chunks of code
get assigned to packages, instance interfaces are built and wrap instance
variables, while helper functions land in their container functions,
various variables get lexicalised in their scopes, etc.

What is also done are countless simplifications, reductions, merges,
unifications, but also splits and duplications where logic and
architecture suggests so or requires.

The starting point for this rework is the official Linux tree commit
2a987e65025e2b79c6d453b78cb5985ac6e5eb26. It is also the base for all
tests performed throughout the process. (Except it changes slightly
with bug fixes.)

The initial fifteen patches are the POD series I published on the Kernel
mailing list. It was already version 3, which somehow got forgotten or
whatever happened to it. You can find it here:
https://lore.kernel.org/linux-doc/20220104015946.529524-1-tomasz.warniello@gmail.com/

One exception here is the copyright patch, which now is version 4.

The final, release version offers:
- ca. 20 bug fixes - big and small
- a few extra features
- no wild globals
- execution time not much worse than the original, despite the internal
  bureaucracy - in fact much better, though maybe not with single files

PATCH ERRATA

For the first ca. 200 patches, when I did indentation and spacing
corrections, I also simplified parentheses. Then I thought I'd better
cover this activity in patch descriptions. Correcting all the early ones
feels far beyond my powers.

PATCH MARKS

1. Enhancements
Patches marked with * at the end of the title contain changes that go
slightly against the master. I'm sometimes unsure if they're enhancements
or bug fixes.

2. Uncertainty
Patches marked with (?) at the of the title are those, which I consider
difficult to check. They may be ok, but should be examined with special
care.

SERIES GUIDE

The first patch in the repository contains the base, ie. the master
version of the script. Please let me know if I should have included
something essential like a license, etc. I've done my research and
came to the conclusion the script can move on its own. But...

The last patch contains this note and a few test scripts I used.

All the patches between them contain only changes to kernel-doc itself.
They are all signed-off.

TESTING

Initially it was chaotic with rst conclusions based on HTML builds and
with scant notes only in every some patch. But it soon got better and
more intelligent. I stated to inspect pure rst and included a note in
every patch unless no test was actually performed. It stayed so ever
after with light tests based on a 200 file sample and heavier tests
covering all available files.

The test reference is the master Linux commit, changing with bugfixes.

REUSE AND PORTING

The series is ready to be pulled by the Linux upstream at will. Of course
I can send it to the Linux mailing list - just let me know. The patches
are signed-off, patch-checked, and ready to go, the best of my knowledge.

That is - except for things like indentation, which is not worse than in
the master if you ask me, but it definitely is far from any claim of
correctness. Not in the conventional sense.

A few patches may undoubtedly be considered egoistic, like the Gedit
syntax highlight helper, or many of the indentation corrections. What can
I say? I needed them. Without them I would be fighting with an uncessant
swarm of tiny difficulties, and would quite likely never get to the end.

What else then? You might be interested in porting bug fixes, which may be
or may not be easy, depending on the case. You might also want to use my
version as an output reference. It's there for you as a whole and as parts.
It's up to you, so help yourselves as you please.

FINAL THOUGHTS

I could have used the POD space prepared for documentation and written
at least general summaries for all modules. But that's another adventure.
I need a break now.

There is still a lot to do around this script. parse_body is a noble warm up
candidate.
