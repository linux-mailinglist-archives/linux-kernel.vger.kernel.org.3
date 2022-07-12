Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8357116E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiGLE1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGLE1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:27:18 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E8286C4;
        Mon, 11 Jul 2022 21:27:17 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F2D7B4006A;
        Tue, 12 Jul 2022 04:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657600035;
        bh=3dbMHGIRCaIC7qUkCvq/dEigxOTe1V8XK3Eynhrmfcw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QOSXArMXk5q6lLj53l+tHKa2NS8wncgRLyCPmyg1Cl93/8f0fxsD5O0MyHB8uXqcc
         6uvfvSvwVIUQfLJX9OSpNly61QgpAPjbUF1vtKY9qfXBgCvJFK5uZ9uFesuJDT84tz
         4EqBozdJ2F0duDdtH06rKpzUAryT9sDdswIHjEP1USBHh1WPDu54ckXMnF11632d9a
         2g/URuP/0Pexsi1FyPYJ3LmAsNI2im6vWYUN+/B2hyobGX4I08wcEl/sI8oJT7RBTF
         vfagkvrXwazh3JQOmeYx0+ZMM10h9f2lMKa4ZtU3R4Oojza0rKCa8XQYITAUhu7hGC
         tiOHXcSdV+EuA==
Message-ID: <1c8c926f-5c21-1565-6687-f473400dc065@canonical.com>
Date:   Mon, 11 Jul 2022 21:27:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build failure after merge of the apparmor tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220712132339.383219ad@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220712132339.383219ad@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 20:23, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the apparmor tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from security/apparmor/include/policy.h:29,
>                   from security/apparmor/include/policy_ns.h:19,
>                   from security/apparmor/include/cred.h:19,
>                   from security/apparmor/net.c:13:
> security/apparmor/net.c: In function 'aa_label_sk_perm':
> security/apparmor/net.c:148:40: error: 'sock' undeclared (first use in this function)
>    148 |         struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
>        |                                        ^~~~
> security/apparmor/include/net.h:54:21: note: in definition of macro 'SK_CTX'
>     54 | #define SK_CTX(X) ((X)->sk_security)
>        |                     ^
> security/apparmor/net.c:148:40: note: each undeclared identifier is reported only once for each function it appears in
>    148 |         struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
>        |                                        ^~~~
> security/apparmor/include/net.h:54:21: note: in definition of macro 'SK_CTX'
>     54 | #define SK_CTX(X) ((X)->sk_security)
>        |                     ^
> 
> Caused by commit
> 
>    6ff81169592d ("apparmor: add a kernel label to use on kernel objects")
> 
> I have used the apparmor tree from next-20220711 for today.
> 
sorry, the offending patch has been dropped

