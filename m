Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224895AFF65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIGIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIGIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:41:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE776B641
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:41:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o126so4917012pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O1lwLIJiyHSQbiRqSTGjeXW6af5i9ZR9TQtgL9JIjKM=;
        b=QzRaKZ3c3+8qYMc/2CX09rn5zTd5NaKeEbgvvIkoe4mJNkJou4yNm4Q9qIgBt7fU4w
         7C9xKyMjQuPpW5EJTvY3fhwR03YMdIsHQqiMqvhpOQ8AYs7u9N+fWVzmq68BlTMfJ1z+
         YWCG9mboCPK/Y+VjmeRY1+qOT/yQfoYbw7veTZaW/z+D5hs91lL9Zf6KzFDL+7BhnexD
         9W223qji6AZW+LWaR8wzQDSEu3CQQ9oefQGdu7thQyrn0sS6YuRUxggAbnj8A5J09V0o
         z+/BD/fQC+BHmTxkhXOLj3qKgz2+BhvYdO/AxJQjfVpLm4Z+t0WisSGxmB/3MiIUxUzC
         Smjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O1lwLIJiyHSQbiRqSTGjeXW6af5i9ZR9TQtgL9JIjKM=;
        b=N65oOsHEZUopVUkizj8bmtsiK76anv3qT6bAs0EY4Cj8Ojq6Yz3oQv0WTrkLZS48q3
         QTvbVezQ7jTZawBhvDcWp3UEWo4DUn5M+LfjRBJgzM7xYtVeIKvJUjwJD2XqKoYYqLf+
         /fI/SS37AS7zigeyKTYf/d1quNI4Z9rkG8irQ/541PFQ1xWFe0Vj9IswNpsCD9BwA7M3
         7Akxw+yoBnvsRtKKhTQDNX/FcLnSkmtOI7aanH5wjZFW29/RT7O8FrC7TcIoyMYprD6g
         twSEgH2xo5sITsX4N90e3dfr78kcBJ973xMSfiEPS2SQBUzDsxmKcmrLZj2nfFL5rBbL
         yRPQ==
X-Gm-Message-State: ACgBeo1sFM0d1J9VYZDFNcIb87JTDHLo5bmUQbEQSn1jXh2K65t95vTu
        /wmole5Hhs6g46mfGcTmW4IPUNqgmG3bB/34+tk=
X-Google-Smtp-Source: AA6agR6oDOdPXhR7WQcpwkC0x2K8sa3KVmB2fRDOZwgYSao1Ggz5/ydrQtrTSqP9T9KEb76lUIpZdf4uad3v2UgnFcM=
X-Received: by 2002:a05:6a00:989:b0:53e:8c95:5f1a with SMTP id
 u9-20020a056a00098900b0053e8c955f1amr290797pfg.12.1662540019132; Wed, 07 Sep
 2022 01:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220902074706.2211252-1-floridsleeves@gmail.com> <20220906215918.3fe20cca@gandalf.local.home>
In-Reply-To: <20220906215918.3fe20cca@gandalf.local.home>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Wed, 7 Sep 2022 01:40:08 -0700
Message-ID: <CAMEuxRqUsKeqtNu1+cwW0a5o_qt56+O7B3EE2sBzsAc9gKhnsQ@mail.gmail.com>
Subject: Re: [PATCH v1] arch/x86/kernel: check the return value of insn_decode_kernel()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 6:58 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  2 Sep 2022 00:47:06 -0700
> Li Zhong <floridsleeves@gmail.com> wrote:
>
> > @@ -20,9 +20,10 @@
> >  int arch_jump_entry_size(struct jump_entry *entry)
> >  {
> >       struct insn insn = {};
> > +     int ret;
> >
> > -     insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
> > -     BUG_ON(insn.length != 2 && insn.length != 5);
> > +     ret = insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
>
> It's highly unlikely that length will be 2 or 5 if ret is not zero (as it
> is initialized to zero going into this function).
>

In this case, I think maybe just BUG_ON(ret<0) is enough. However, the code
that decides the value of insn->length could be modified in the future. And
there are other variables insn->next_byte and insn->kaddr that are related to
insn->length, which could also be modified. So I guess we can preserve all the
assertion conditions to guarantee all assumptions are satisfied.

> > +     BUG_ON(ret < 0 || insn.length != 2 && insn.length != 5);
>
> In any case, you need parenthesis around the && condition.
>

Thanks. Will add this in v2 patch.

> -- Steve
>
>
> >
> >       return insn.length;
