Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2954403A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiFHX7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFHX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:59:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E951B6FC2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:59:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so30518457ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HL4pyz552FBsgBnW1SFjlcHSshRtDZGTUGirGdiUozU=;
        b=B3PW1aZy7J/jYvh53GlIU/iYmD74bYN/sIOQCE9xSK9ZYKRs9gtlNR7LrPBaccvH/9
         fIkONSDZyV79TvM5yiH0+Cs6L/JqBJ1YAwTMtILxle8rTB28414n0sMNmSjw/VeEmqF5
         gXeWOIKYlp2i5aefoOFR7eGt3UbciV4mm8ahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HL4pyz552FBsgBnW1SFjlcHSshRtDZGTUGirGdiUozU=;
        b=YgseHExeJZqU56ByrtA9ne/kNPQwF5Zu6quARvTnVUwgPs62wy6WYSEKwWQkvkBAiB
         JNhk2P7uYwIPLOnDZCuWOs96isjkGnHjLcPvDJLIi2dBDVTx+ZjUkzBXTZScT1Uoeq/k
         vr/5qooFB3902GJhG+mYdJSwYnWC5k9NeEYjsoPTW9/20hY6eYxdo6q8Wn31QOVBAbTk
         caoap6W8WpqfTTtWRDMJnql96G9RyYCNF5mrJS8ZUw5OPJyEH0vRK0ONQOvNKBJxWhON
         WR6IJiLsq4+iCaQrrcgPXC7zEZTzIdyxYhYjm/jnu4UQUEOLhM25rLZx57xTnMABLVQw
         eAtQ==
X-Gm-Message-State: AOAM530UkF+uq6hEqpkRcrLlr0p65SgmEZ5YGiQhJRkV+Zh28T6UGxsy
        P5oPq5fBoknhtDyQP8NtPvxtHjAMj09V0LRT
X-Google-Smtp-Source: ABdhPJx3AkB/yNHokMRD/DpqUotDP02yT8hYMF4LnbmwsZc6+vzYat+Lujyd01kWXavV7FyQC08OWQ==
X-Received: by 2002:a17:906:25d8:b0:6fe:9f11:3906 with SMTP id n24-20020a17090625d800b006fe9f113906mr32909280ejb.538.1654732787077;
        Wed, 08 Jun 2022 16:59:47 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm9952809ejs.99.2022.06.08.16.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 16:59:46 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h5so30289906wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:59:46 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr28893206wrq.97.1654732785866; Wed, 08
 Jun 2022 16:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com> <202206081404.F98F5FC53E@keescook>
In-Reply-To: <202206081404.F98F5FC53E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jun 2022 16:59:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
Message-ID: <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     Kees Cook <keescook@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e68e4105e0f87f4c"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e68e4105e0f87f4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 8, 2022 at 2:33 PM Kees Cook <keescook@chromium.org> wrote:
>
> I and others have been working through a bunch of them, though yes,
> they're not all fixed yet. I've been trying to track it here[1], but
> many of those fixes are only in -next.

Hmm. Even with that disabled, I get a few warnings I *really* would
want to get rid of.

The one in ipuv3-crtc.c seems valid about "address used as boolean is
always true".

The 'dangling-pointer' warning does seem interesting, but not when the
compiler does as bad a job as gcc seems to do.

See the attached patch for

 (a) make the s390 "use -Wno-array-bounds for gcc-12" be generic

 (b) fix the ipuv3-crtc.c one. IMX people?

 (c) disable -Wdangling-pointer entirely for now

but that still leaves the netfs_i_context games, which gcc-12 is very
unhappy about:

  In function =E2=80=98fortify_memset_chk=E2=80=99,
      inlined from =E2=80=98netfs_i_context_init=E2=80=99 at ./include/linu=
x/netfs.h:327:2,
      inlined from =E2=80=98afs_set_netfs_context=E2=80=99 at fs/afs/inode.=
c:61:2,
      inlined from =E2=80=98afs_inode_init_from_status=E2=80=99 at fs/afs/i=
node.c:139:2:
  ./include/linux/fortify-string.h:258:25: error: call to
=E2=80=98__write_overflow_field=E2=80=99 declared with attribute warning: d=
etected
write beyond size of field (1st parameter); maybe use struct_group()?
[-Werror=3Dattribute-warning]

and I do kind of agree with the compiler in that case. That code
should have some kind of

  struct container {
        struct inode inode;
        struct netfs_i_context ctx;
   };

thing, and aim to do that instead of the pointer arithmetic games.

Ceph seems to trigger the exact same thing.

There's also an annoying mlx5 issue, with gcc apparently not tracking
the usage of

        struct lag_tracker tracker;

well enough (it's never used if do_bond is false, but probably some
inlining change means that gcc doesn't see that).

DavidH - mind looking at the netfs_i_context_init() thing?

I'd like to use something more surgical than
CONFIG_CC_NO_ARRAY_BOUNDS, but considering the s390 issues, it may not
even be worth it. Kees, just how far away are we from that being ok on
x86-64?

I did consider making CONFIG_CC_NO_ARRAY_BOUNDS be more akin to

 config CC_NO_ARRAY_BOUNDS
        bool
        depends on CC_IS_GCC
        depends on GCC_VERSION >=3D 120000 && GCC_VERSION < 130000
        default GCC12_NO_ARRAY_BOUNDS

and then s390 and any subsystem that triggers the -Warray-bounds problem ca=
n do

        select GCC12_NO_ARRAY_BOUNDS

to show that they have issues with the new gcc12 rules.

That would be at least a bit more surgical..

                  Linus

--000000000000e68e4105e0f87f4c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l468v6ie0>
X-Attachment-Id: f_l468v6ie0

IE1ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKysrKwogYXJjaC9zMzkwL01h
a2VmaWxlICAgICAgICAgICAgICAgfCAxMCArLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vaW14
L2lwdXYzLWNydGMuYyB8ICAyICstCiBpbml0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8
ICA1ICsrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggYzQzZDgyNWEzYzRj
Li5iMmU5M2MxYTgwMjEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC03
ODgsNiArNzg4LDcgQEAgc3RhY2twLWZsYWdzLSQoQ09ORklHX1NUQUNLUFJPVEVDVE9SX1NUUk9O
RykgICAgICA6PSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcKIEtCVUlMRF9DRkxBR1MgKz0gJChz
dGFja3AtZmxhZ3MteSkKIAogS0JVSUxEX0NGTEFHUy0kKENPTkZJR19XRVJST1IpICs9IC1XZXJy
b3IKK0tCVUlMRF9DRkxBR1MtJChDT05GSUdfQ0NfTk9fQVJSQVlfQk9VTkRTKSArPSAtV25vLWFy
cmF5LWJvdW5kcwogS0JVSUxEX0NGTEFHUyArPSAkKEtCVUlMRF9DRkxBR1MteSkgJChDT05GSUdf
Q0NfSU1QTElDSVRfRkFMTFRIUk9VR0gpCiAKIGlmZGVmIENPTkZJR19DQ19JU19DTEFORwpAQCAt
ODA1LDYgKzgwNiw5IEBAIGVuZGlmCiBLQlVJTERfQ0ZMQUdTICs9ICQoY2FsbCBjYy1kaXNhYmxl
LXdhcm5pbmcsIHVudXNlZC1idXQtc2V0LXZhcmlhYmxlKQogS0JVSUxEX0NGTEFHUyArPSAkKGNh
bGwgY2MtZGlzYWJsZS13YXJuaW5nLCB1bnVzZWQtY29uc3QtdmFyaWFibGUpCiAKKyMgVGhlc2Ug
cmVzdWx0IGluIGJvZ3VzIGZhbHNlIHBvc2l0aXZlcworS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwg
Y2MtZGlzYWJsZS13YXJuaW5nLCBkYW5nbGluZy1wb2ludGVyKQorCiBpZmRlZiBDT05GSUdfRlJB
TUVfUE9JTlRFUgogS0JVSUxEX0NGTEFHUwkrPSAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciAtZm5v
LW9wdGltaXplLXNpYmxpbmctY2FsbHMKIGVsc2UKZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9NYWtl
ZmlsZSBiL2FyY2gvczM5MC9NYWtlZmlsZQppbmRleCBkNzM2MTFiMzUxNjQuLmUxYWJiMGQwMzgy
NCAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL01ha2VmaWxlCisrKyBiL2FyY2gvczM5MC9NYWtlZmls
ZQpAQCAtMzIsMTUgKzMyLDcgQEAgS0JVSUxEX0NGTEFHU19ERUNPTVBSRVNTT1IgKz0gLWZuby1z
dGFjay1wcm90ZWN0b3IKIEtCVUlMRF9DRkxBR1NfREVDT01QUkVTU09SICs9ICQoY2FsbCBjYy1k
aXNhYmxlLXdhcm5pbmcsIGFkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcikKIEtCVUlMRF9DRkxBR1Nf
REVDT01QUkVTU09SICs9ICQoaWYgJChDT05GSUdfREVCVUdfSU5GTyksLWcpCiBLQlVJTERfQ0ZM
QUdTX0RFQ09NUFJFU1NPUiArPSAkKGlmICQoQ09ORklHX0RFQlVHX0lORk9fRFdBUkY0KSwgJChj
YWxsIGNjLW9wdGlvbiwgLWdkd2FyZi00LCkpCi0KLWlmZGVmIENPTkZJR19DQ19JU19HQ0MKLQlp
ZmVxICgkKGNhbGwgY2MtaWZ2ZXJzaW9uLCAtZ2UsIDEyMDAsIHkpLCB5KQotCQlpZmVxICgkKGNh
bGwgY2MtaWZ2ZXJzaW9uLCAtbHQsIDEzMDAsIHkpLCB5KQotCQkJS0JVSUxEX0NGTEFHUyArPSAk
KGNhbGwgY2MtZGlzYWJsZS13YXJuaW5nLCBhcnJheS1ib3VuZHMpCi0JCQlLQlVJTERfQ0ZMQUdT
X0RFQ09NUFJFU1NPUiArPSAkKGNhbGwgY2MtZGlzYWJsZS13YXJuaW5nLCBhcnJheS1ib3VuZHMp
Ci0JCWVuZGlmCi0JZW5kaWYKLWVuZGlmCitLQlVJTERfQ0ZMQUdTX0RFQ09NUFJFU1NPUiArPSAk
KGlmICQoQ0NfTk9fQVJSQVlfQk9VTkRTKSwtV25vLWFycmF5LWJvdW5kcykKIAogVVRTX01BQ0hJ
TkUJOj0gczM5MHgKIFNUQUNLX1NJWkUJOj0gJChpZiAkKENPTkZJR19LQVNBTiksNjU1MzYsMTYz
ODQpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9pbXgvaXB1djMtY3J0Yy5jCmluZGV4IDljODgyOWY5NDViMi4uZjc4NjNkNmRl
YTgwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYwpAQCAtNjksNyArNjksNyBAQCBzdGF0aWMg
dm9pZCBpcHVfY3J0Y19kaXNhYmxlX3BsYW5lcyhzdHJ1Y3QgaXB1X2NydGMgKmlwdV9jcnRjLAog
CWRybV9hdG9taWNfY3J0Y19zdGF0ZV9mb3JfZWFjaF9wbGFuZShwbGFuZSwgb2xkX2NydGNfc3Rh
dGUpIHsKIAkJaWYgKHBsYW5lID09ICZpcHVfY3J0Yy0+cGxhbmVbMF0tPmJhc2UpCiAJCQlkaXNh
YmxlX2Z1bGwgPSB0cnVlOwotCQlpZiAoJmlwdV9jcnRjLT5wbGFuZVsxXSAmJiBwbGFuZSA9PSAm
aXB1X2NydGMtPnBsYW5lWzFdLT5iYXNlKQorCQlpZiAoaXB1X2NydGMtPnBsYW5lWzFdICYmIHBs
YW5lID09ICZpcHVfY3J0Yy0+cGxhbmVbMV0tPmJhc2UpCiAJCQlkaXNhYmxlX3BhcnRpYWwgPSB0
cnVlOwogCX0KIApkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmlnIGIvaW5pdC9LY29uZmlnCmluZGV4
IGM5ODRhZmM0ODlkZS4uY2NiMTMwMmQ2ZWRkIDEwMDY0NAotLS0gYS9pbml0L0tjb25maWcKKysr
IGIvaW5pdC9LY29uZmlnCkBAIC04ODUsNiArODg1LDExIEBAIGNvbmZpZyBDQ19JTVBMSUNJVF9G
QUxMVEhST1VHSAogCWRlZmF1bHQgIi1XaW1wbGljaXQtZmFsbHRocm91Z2g9NSIgaWYgQ0NfSVNf
R0NDICYmICQoY2Mtb3B0aW9uLC1XaW1wbGljaXQtZmFsbHRocm91Z2g9NSkKIAlkZWZhdWx0ICIt
V2ltcGxpY2l0LWZhbGx0aHJvdWdoIiBpZiBDQ19JU19DTEFORyAmJiAkKGNjLW9wdGlvbiwtV3Vu
cmVhY2hhYmxlLWNvZGUtZmFsbHRocm91Z2gpCiAKK2NvbmZpZyBDQ19OT19BUlJBWV9CT1VORFMK
Kwlib29sCisJZGVwZW5kcyBvbiBDQ19JU19HQ0MKKwlkZWZhdWx0IHkgaWYgR0NDX1ZFUlNJT04g
Pj0gMTIwMDAwICYmIEdDQ19WRVJTSU9OIDwgMTMwMDAwCisKICMKICMgRm9yIGFyY2hpdGVjdHVy
ZXMgdGhhdCBrbm93IHRoZWlyIEdDQyBfX2ludDEyOCBzdXBwb3J0IGlzIHNvdW5kCiAjCg==
--000000000000e68e4105e0f87f4c--
