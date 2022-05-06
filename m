Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294351DB13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442449AbiEFOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiEFOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:51:50 -0400
X-Greylist: delayed 12488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 07:48:07 PDT
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D866AA5C;
        Fri,  6 May 2022 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651848487;
        bh=mYBYsb4+IcqpXrniKQp6OcZ7ENW1vFpyI82r9PoW1UM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=e/Lc4cT6B8c1Tm4QY5U1muirjRqkwoPTuJpxSkWn+NQQX+Zs0JMVkQGKhHmgZP+WL
         sfCmchYkopaUYYg5oHuh+nXDeHHhqwrdqPqUUjF2iA7mhSqcHby3gCAEqQrQCIJ1eT
         nx63fKEamNyzn5K7zKaDf1h/08Wz0HrCFALN/CnU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0B9B3128694D;
        Fri,  6 May 2022 10:48:07 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hfu_FKLUTw1k; Fri,  6 May 2022 10:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651848486;
        bh=mYBYsb4+IcqpXrniKQp6OcZ7ENW1vFpyI82r9PoW1UM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pOXX8GI578qtb2rtCb9mYA7vAb4F3V/Ra/z6yIkl6XjdXSjbSetj+XStYQLIlev1g
         GMVHeakSGIcSEO+4y6dxOljb5rFamXyuxaQah/3IeElP+vLNnpoCKnNMc8vmSabs48
         OMm/TFP9ZkesKIvsvTtR1RCGP8R0fnPyY01AeBhY=
Received: from lingrow.rcx-us.ibmmobiledemo.com (unknown [129.41.87.19])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F0DC912868FE;
        Fri,  6 May 2022 10:48:05 -0400 (EDT)
Message-ID: <80715dbbf1f34853697e3aa6b3c74bc381000cc4.camel@HansenPartnership.com>
Subject: Re: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Date:   Fri, 06 May 2022 10:48:04 -0400
In-Reply-To: <CANiq72m0unKrwRrb-tnYZ5w5oodJQ+3wNHMaQazeUSCOfUBJiQ@mail.gmail.com>
References: <20220505191704.22812-1-ojeda@kernel.org>
         <20220505191704.22812-2-ojeda@kernel.org>
         <7e20c844dadacb3dac822220ca108f4d786ceb7d.camel@HansenPartnership.com>
         <CANiq72m0unKrwRrb-tnYZ5w5oodJQ+3wNHMaQazeUSCOfUBJiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-06 at 14:58 +0200, Miguel Ojeda wrote:
> Hi James,
> 
> On Fri, May 6, 2022 at 1:19 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > When you raise KSYM_NAME_LEN to 512, this on stack allocation
> > becomes 2049 bytes.  How did you manage not to trigger the frame
> > size warning, which is 1024 on 32 bit and 2048 on 64 bit by
> > default?
> 
> Thanks for taking a look!
> 
> If you mean `CONFIG_FRAME_WARN`, that applies to kernel objects, not
> scripts.

Oh, right, I missed that it was a script.  Forget the comment then; we
only have a restricted stack inside the kernel not in userspace.

James


