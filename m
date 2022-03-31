Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04354EE03D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiCaSTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiCaSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:19:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52B1E6E9C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:17:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so618502lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gADLe4HDBmNTTRadD9I18Eo59xDMA1VeRyu9AlQVupI=;
        b=crQ0nfYz9r5y0LNjvAz6Kl9GkH8VcN7+M3IRO0/MHMSfuwZ3QQbJPMFmMEChGOGuRi
         lgQsMapR+mH3g1uSCfkahgw35sLDQIFcmdfsSdI3qkJ8Vg8TWDA8dUjlprf7JcAT2Psh
         pjWsZFv1Yzq1yQ6rqecDWGyO9u5lr3MHZuD6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gADLe4HDBmNTTRadD9I18Eo59xDMA1VeRyu9AlQVupI=;
        b=YDWVu4NLDPu2fFybT8YirFs/Zz7s+qQyGCi9sT/uQjhr4Ppa82psspMjbKssqzBjfy
         DNv8Ii/B8X6KekbnohH0g0RG75pEPd1nu0T65kuxhrfH1BQ5x0U7YKAstrna0m4MPW5s
         Tc56lR6sl8A48YrqphMt1JKUD4Blb90XE0p+vY7vQDi/4RaWwhU1v8E03hZzO0ejn7Yt
         6SVA6gLR6RIXVXok/Goktgvl2InGtU4jvoE1XlDOyiaPcc4CXgdvkbNyeIwFyPM98ggr
         z21WyZ04g8wm0wAdyw/RHUCragKqdHRYqrbdxo4FAbDJ4J0kvmb06Gr462x4H0x5prT4
         kebA==
X-Gm-Message-State: AOAM533Za2mUOflNjuF4AdSbRRSbpSFvkfB2hJSG2LWK7ty12OlmcZIz
        oVithAleZwTUGeJgTeJIO5wu4nkURwe+Yh+6
X-Google-Smtp-Source: ABdhPJz6sZ5uKX8JlbuVduNYhZf7DqrkzT2K8JIOKOD56j3NV7Fr8CaCoaz6bY8Bq8ZVA6qeF+NTYA==
X-Received: by 2002:a05:6512:ad3:b0:44a:614e:9d4d with SMTP id n19-20020a0565120ad300b0044a614e9d4dmr11297345lfu.557.1648750632100;
        Thu, 31 Mar 2022 11:17:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k2-20020a056512330200b0044a096ea7absm10846lfe.54.2022.03.31.11.17.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:17:10 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h11so902195ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:17:10 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr11242362ljg.291.1648750629685; Thu, 31
 Mar 2022 11:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220126171442.1338740-1-aurelien@aurel32.net>
 <20220331103247.y33wvkxk5vfbqohf@pengutronix.de> <20220331103913.2vlneq6clnheuty6@pengutronix.de>
 <20220331105112.7t3qgtilhortkiq4@pengutronix.de>
In-Reply-To: <20220331105112.7t3qgtilhortkiq4@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 11:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnuMD091mNbY=fRm-qFyhMjbtfiwkAFKyFehyR8bPB5A@mail.gmail.com>
Message-ID: <CAHk-=wjnuMD091mNbY=fRm-qFyhMjbtfiwkAFKyFehyR8bPB5A@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix build with binutils 2.38
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kito Cheng <kito.cheng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        ukl@pengutronix.de,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009b482f05db87ab14"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009b482f05db87ab14
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 31, 2022 at 3:51 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Cc += linux-sparse, Uwe, Luc Van Oostenryck
>
> tl;dr:
>
> A recent change in the kernel regarding the riscv -march handling breaks
> current sparse.

Gaah. Normally sparse doesn't even look at the -march flag, but for
riscv it does, because it's meaningful for the predefined macros.

Maybe that 'die()' shouldn't be so fatal. And maybe add a few more
extensions (but ignore them) to the parsing.

Something ENTIRELY UNTESTED like the attached.

               Linus

--0000000000009b482f05db87ab14
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1fbjlbv0>
X-Attachment-Id: f_l1fbjlbv0

IHRhcmdldC1yaXNjdi5jIHwgMTQgKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC1yaXNjdi5j
IGIvdGFyZ2V0LXJpc2N2LmMKaW5kZXggNmQ5MTEzYzEuLjIwMWFjMzc1IDEwMDY0NAotLS0gYS90
YXJnZXQtcmlzY3YuYworKysgYi90YXJnZXQtcmlzY3YuYwpAQCAtMyw2ICszLDcgQEAKICNpbmNs
dWRlICJ0YXJnZXQuaCIKICNpbmNsdWRlICJtYWNoaW5lLmgiCiAjaW5jbHVkZSA8c3RyaW5nLmg+
CisjaW5jbHVkZSA8c3RkaW8uaD4KIAogI2RlZmluZSBSSVNDVl8zMkJJVAkoMSA8PCAwKQogI2Rl
ZmluZSBSSVNDVl82NEJJVAkoMSA8PCAxKQpAQCAtNDcsNiArNDgsMTIgQEAgc3RhdGljIHZvaWQg
cGFyc2VfbWFyY2hfcmlzY3YoY29uc3QgY2hhciAqYXJnKQogCQl7ICJuIiwJCTAgfSwKIAkJeyAi
aCIsCQkwIH0sCiAJCXsgInMiLAkJMCB9LAorCQl7ICJpIiwJCTAgfSwKKwkJeyAiZSIsCQkwIH0s
CisJCXsgIl8iLAkJMCB9LAorCQl7ICJDb3VudGVycyIsCTAgfSwKKwkJeyAiWmljc3IiLAkwIH0s
CisJCXsgIlppZmVuY2VpIiwJMCB9LAogCX07CiAJaW50IGk7CiAKQEAgLTYwLDcgKzY3LDEwIEBA
IHN0YXRpYyB2b2lkIHBhcnNlX21hcmNoX3Jpc2N2KGNvbnN0IGNoYXIgKmFyZykKIAkJCWdvdG8g
ZXh0OwogCQl9CiAJfQotCWRpZSgiaW52YWxpZCBhcmd1bWVudCB0byAnLW1hcmNoJzogJyVzJ1xu
IiwgYXJnKTsKKwordW5rbm93bjoKKwlmcHJpbnRmKHN0ZGVyciwgIldBUk5JTkc6IGludmFsaWQg
YXJndW1lbnQgdG8gJy1tYXJjaCc6ICclcydcbiIsIGFyZyk7CisJcmV0dXJuOwogCiBleHQ6CiAJ
Zm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZXh0ZW5zaW9ucyk7IGkrKykgewpAQCAtNzMsNyAr
ODMsNyBAQCBleHQ6CiAJCX0KIAl9CiAJaWYgKGFyZ1swXSkKLQkJZGllKCJpbnZhbGlkIGFyZ3Vt
ZW50IHRvICctbWFyY2gnOiAnJXMnXG4iLCBhcmcpOworCQlnb3RvIHVua25vd247CiB9CiAKIHN0
YXRpYyB2b2lkIGluaXRfcmlzY3YoY29uc3Qgc3RydWN0IHRhcmdldCAqc2VsZikK
--0000000000009b482f05db87ab14--
