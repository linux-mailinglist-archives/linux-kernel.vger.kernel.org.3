Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9694E46AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiCVTb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiCVTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BAE579388
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647977428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5V/hUtU1eWPYAfu3Vkm3R/UNQxwyoHX973gqDqsE8I=;
        b=FYZPx3PShsAaApuk8DFuWpRZWgrzgFm4+sMmnEAt29joSEgg76ZPa81d3Z7pFllZuv+D0u
        bX4owp6zDPvAN91pDXIN16OB1+NM0uCPJpByWWdPc+VOLWYAJ6a8YCkWsaEfx6I0PdU7EE
        QGeqNEaVbPn1IkSiApBB4arCK+3jO7k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-yC_o1YQuPee2IKSjRCLbVg-1; Tue, 22 Mar 2022 15:30:26 -0400
X-MC-Unique: yC_o1YQuPee2IKSjRCLbVg-1
Received: by mail-qk1-f197.google.com with SMTP id y140-20020a376492000000b0067b14129a63so12469121qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5V/hUtU1eWPYAfu3Vkm3R/UNQxwyoHX973gqDqsE8I=;
        b=n+IUPtxNE18QRHlVGIvWugYRdBxQBUczhLY87mlA4m6w3/Cd0KdBU7JNhVjy5oEQZ3
         ke1y3RuWoU+gbNR9m75JfLzMzvTzOiCaM93tULXBKh7hgd3gHbZRAe3fmhZG+FJCXlmx
         ib5BNH/vKaDMwtHVPdg+guoXS/SrcW5Q/rDZYiJPeN/hwE9mV+fBCQSDkXoQd0Wsz/g9
         0dD/8ermuTd8uxmlN64w7JsDRkrg8CDj4eA0M3TouefEijdMXl7vMD8zN3qx3LPPbANc
         BmKAPfLHTkVVUfuTbBjdlOryW1gha5N1FLKxwDRrAd5mHOtN79YJ91Rv4Ddk5mkQSYh9
         MOYg==
X-Gm-Message-State: AOAM5335b6t9QnogWYLXKEvaDXop2fmujav+KbMX26r2VnE81ieGjT8k
        hpVZ+OIhw99Wd31A3CF4wITedpdcIu6E9LohD3g/EYelELxNEzmNCeBnX/HgOvxGOftQ0lIEF/5
        WVQeoaNVv4LhIaNxyxbHrtRjuEI7gOH1VRjZexB4n
X-Received: by 2002:a05:620a:c46:b0:67e:1559:559a with SMTP id u6-20020a05620a0c4600b0067e1559559amr16097360qki.437.1647977426249;
        Tue, 22 Mar 2022 12:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+VQun41HDweR1Q6kFjVMaBNO1gZRC3yTuomyULbugtJxnjMIxasm8DtUv+co5J5RPeBaDxYQKjXqd654EoCw=
X-Received: by 2002:a05:620a:c46:b0:67e:1559:559a with SMTP id
 u6-20020a05620a0c4600b0067e1559559amr16097353qki.437.1647977426061; Tue, 22
 Mar 2022 12:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com>
In-Reply-To: <20220322192712.709170-1-mszeredi@redhat.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 22 Mar 2022 20:30:15 +0100
Message-ID: <CAOssrKcJT=HCYW1tUwUaZbD8gi2CNh4__7Q6kqTPsdxF07dmBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: multipart/mixed; boundary="000000000000148ba905dad3a5c2"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000148ba905dad3a5c2
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 22, 2022 at 8:27 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Add a new userspace API that allows getting multiple short values in a
> single syscall.

Attaching a test program that allows arbitrary queries.

Thanks,
Miklos

--000000000000148ba905dad3a5c2
Content-Type: text/x-csrc; charset="US-ASCII"; name="getvalues.c"
Content-Disposition: attachment; filename="getvalues.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l12j71mq0>
X-Attachment-Id: f_l12j71mq0

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVyci5oPgojaW5jbHVkZSA8c3RkaW50Lmg+
CiNpbmNsdWRlIDxzeXMvdWlvLmg+CgpzdHJ1Y3QgbmFtZV92YWwgewoJY29uc3QgY2hhciAqbmFt
ZTsJLyogaW4gKi8KCXN0cnVjdCBpb3ZlYyB2YWx1ZV9pbjsJLyogaW4gKi8KCXN0cnVjdCBpb3Zl
YyB2YWx1ZV9vdXQ7CS8qIG91dCAqLwoJdWludDMyX3QgZXJyb3I7CQkvKiBvdXQgKi8KCXVpbnQz
Ml90IHJlc2VydmVkOwp9OwoKCmludCBnZXR2YWx1ZXMoaW50IGRmZCwgY29uc3QgY2hhciAqcGF0
aCwgc3RydWN0IG5hbWVfdmFsICp2ZWMsIHNpemVfdCBudW0sCgkgICAgICB1bnNpZ25lZCBpbnQg
ZmxhZ3MpCnsKCXJldHVybiBzeXNjYWxsKDQ1MSwgZGZkLCBwYXRoLCB2ZWMsIG51bSwgZmxhZ3Mp
Owp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CgljaGFyICpzLCBidWZbNDA5
Nl07CglpbnQgcmVzLCBpLCBvLCBudW0gPSBhcmdjIC0gMjsKCXN0cnVjdCBuYW1lX3ZhbCBudnNb
MjU2XSA9IHt9OwoKCWlmIChhcmdjIDwgMykKCQllcnJ4KDEsICJ1c2FnZTogJXMgcGF0aCBuYW1l
IFsuLi5dIiwgYXJndlswXSk7CglpZiAobnVtID4gMjU2KQoJCWVycngoMSwgInRvbyBtYW55IGFy
Z3VtZW50cyIpOwoKCWZvciAoaSA9IDA7IGkgPCBudW07IGkrKykKCQludnNbaV0ubmFtZSA9IGFy
Z3ZbaSArIDJdOwoKCW52c1swXS52YWx1ZV9pbi5pb3ZfYmFzZSA9IGJ1ZjsKCW52c1swXS52YWx1
ZV9pbi5pb3ZfbGVuID0gc2l6ZW9mKGJ1Zik7CgoJcmVzID0gZ2V0dmFsdWVzKEFUX0ZEQ1dELCBh
cmd2WzFdLCBudnMsIG51bSwgMCk7CglpZiAocmVzID09IC0xKQoJCWVycigxLCBOVUxMKTsKCglu
dW0gPSByZXM7Cglmb3IgKGkgPSAwOyBpIDwgbnVtOyBpKyspIHsKCQlwcmludGYoIlslc10gPSAi
LCBudnNbaV0ubmFtZSk7CgkJcmVzID0gbnZzW2ldLmVycm9yOwoJCWlmIChyZXMpIHsKCQkJcHJp
bnRmKCIgRVJST1I6ICVzICglaSlcbiIsIHN0cmVycm9yKHJlcyksIHJlcyk7CgkJfSBlbHNlIHsK
CQkJcmVzID0gbnZzW2ldLnZhbHVlX291dC5pb3ZfbGVuOwoJCQlzID0gbnZzW2ldLnZhbHVlX291
dC5pb3ZfYmFzZTsKCgkJCWZvciAobyA9IDA7IG8gPCByZXM7IG8gKz0gc3RybGVuKHMgKyBvKSAr
IDEpCgkJCQlwcmludGYoIlwiJS4qc1wiICIsIHJlcyAtIG8sIHMgKyBvKTsKCgkJCXByaW50Zigi
KGxlbj0laSlcbiIsIHJlcyk7CgkJfQoJfQoJcmV0dXJuIDA7Cn0K
--000000000000148ba905dad3a5c2--

