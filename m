Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0020F4F6BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiDFU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiDFU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:57:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA3AA032;
        Wed,  6 Apr 2022 12:22:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n38-20020a05600c502600b0038e4a0fc5easo2275134wmr.3;
        Wed, 06 Apr 2022 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iu6MPxqoRml8OFzXx+GLxZc5HYFamy88AoTVTPLpcvk=;
        b=n7IZEXBXrl1GhzqxvFz151kKjEIwjvfdcsQX+c45CFHMlsfAHTiJMf30bbir+2PPmR
         5gPyGY55s94m/rJCSSWek6ZlCWAuz/zGz9E1Jz9jaiVv4rWN7ZhQPmbFVyfxCIsyWLZ5
         70rnueAds0huqpGKdVcYsxBKDL/7ANBXBdVbMW4/9GqJfQ8U6GyZu+t7br6D/ddPwlQY
         9H7hYKtqM0CZM8KgJ6iv5le+ixaZO6b3ZamIrQHcDbhhW4p5g83I3J4juuV7KR9+0NH7
         BLbjFtFi1Aaz7+Owh7gE4YWRzxgMnxbMle/Eh0kS2FYhdHbRfhsJbmH7FNFRCf9olAAF
         6iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iu6MPxqoRml8OFzXx+GLxZc5HYFamy88AoTVTPLpcvk=;
        b=M+xCHxOj/ICWqx5dRnypbZT7mCOevoqs316XdNQt+W6KgJeqPv3OVDScupPCqcZjA/
         Bv7A9nhWNsY8PCvGOC2DYLyIujOCetY118Hwyg1JIzPg0EJXERh9wshoHv7RCDAit85L
         V++pDH7XcvIHbAH55T0jTR5X7pAbL9MJ2YssXdCy7lhoeCtTFYQpU+uZbquFZv2dxayr
         HomJCC3uP/ZcnCxnReluYNgDTkx5fZhHsde7eCR3thS/2FmO3CBYVQfJdseCMc7JSJfp
         tRRIQ+shoiZj+Ccf83u49m5fF/zkaOvqyT1nkNqlakgWIQtq+Rh9DECqn80sGIRx0uuZ
         BHCQ==
X-Gm-Message-State: AOAM533lHtOjlOSu/MByjD6LLLOK0KGjRmQSyTbyaYG7PFMwhBfWOuej
        p0j+444RwkHm8ds9XLWDfGA=
X-Google-Smtp-Source: ABdhPJyUtzOT5LRbeFbXjDvXdNRUw3TvF/HRolEgh49iro5FqtunRU/hrFYIBsH1L+4tngrpyfpwyA==
X-Received: by 2002:a05:600c:3d8d:b0:38c:6f6e:e61a with SMTP id bi13-20020a05600c3d8d00b0038c6f6ee61amr8860020wmb.101.1649272935827;
        Wed, 06 Apr 2022 12:22:15 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b0038c6c37efc3sm5482701wmq.12.2022.04.06.12.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:22:15 -0700 (PDT)
Message-ID: <f21a06dc-1e2a-87cd-59dc-e8d5245b0a50@gmail.com>
Date:   Wed, 6 Apr 2022 21:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: vfork(2) behavior not consistent with fork(2) (was: vfork(2) fails
 after unshare(CLONE_NEWTIME) (was: [Bug 215769] man 2 vfork() does not
 document corner case when PID == 1))
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LA=?= =?UTF-8?B?0YDQug==?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        bugzilla-daemon@kernel.org, linux-api@vger.kernel.org
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
 <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
 <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
 <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
 <20220406084613.3srklyt27qxcmrcx@wittgenstein>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220406084613.3srklyt27qxcmrcx@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> $ sudo ./vfork_newpid
> vfork_newpid: PID: 8479
> vfork_newpid: PID 8479 exiting after execve(2): Success
> print_pid: PID 1 exiting. 


I definitely think this is a kernel (or glibc) bug.
execve(2) is supposed to _never_ return 0 (and errno 0).
I submitted a new bug to discuss it.

Please see <https://bugzilla.kernel.org/show_bug.cgi?id=215813>
