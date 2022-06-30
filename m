Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EE562082
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiF3Ql0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiF3QlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:41:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D73BBF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:41:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a2so34759126lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMOwDWIfg0entuc2l+NsGII8SSnnX37Y724/yrdR39A=;
        b=SmXL8TSEYyAq3nujYp/HKJzpFnRJ53Zf9BeRIJwii4TmrV7NfiW+RpxFNhJvsnltQV
         E2cAsXAJNurB1qnDKUQTiCAiuzvQNJEV2T8xSos/koIjPtO42WmVVo9CpSLd8E43lA4H
         RvLWUIviiQSD1CBhdAogo9N3fHQkcsimZFrOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMOwDWIfg0entuc2l+NsGII8SSnnX37Y724/yrdR39A=;
        b=nlpjArUp4Sjz7uSxWpkY6+kdS+lwgxEWhQ3wWcRAeR6uPJgB1XZ7AspHFtG+FdEHNL
         lBHaWLdcDBCfZKu4Doz53zr3uljOThB8rWoZ34ByqvHl2IqeRn6oA1d+oQxrj+YrGF+n
         bbNpCKSqwhkJmmc++8hzXYJmKvhDFmK4aT/dKL5RfDtFa/qb8o4mXayqrRmcjCYWwO9/
         pM2rIsBGwUY8OCC4J976a6JQw3WB/OfzXalp6lEM5DT6XrektRuglKbveC3BabP0f33p
         6m8ngphL30qmFiqQLcjae/w6cnknvuQoK/Rw00LxGSdGpBVkwYdOYvWUYhLxz1RTC/jn
         phFg==
X-Gm-Message-State: AJIora/pvGwIS/fWxzk6nvCcirvvEgaT9XpaYtCOeYkOuNfaBAjRpdPm
        Ideet2ohCG40Vsy0KlqoQUhBgRmOgGGkQBwe6Zg=
X-Google-Smtp-Source: AGRyM1sLU+7IC4gUPU7xiMdgssWyv4PzotHiBCpshw2l/yGMvwY+3gXSTE8DbxdbG/ULTrujxIMO/w==
X-Received: by 2002:a05:6512:398d:b0:47f:897f:bf31 with SMTP id j13-20020a056512398d00b0047f897fbf31mr6381447lfu.157.1656607280920;
        Thu, 30 Jun 2022 09:41:20 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o23-20020a05651205d700b0047f62762100sm3171897lfo.138.2022.06.30.09.41.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 09:41:20 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z13so34645564lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:41:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1148:b0:21b:a4b2:ccd3 with SMTP id
 d8-20020a056000114800b0021ba4b2ccd3mr9386518wrx.193.1656606867259; Thu, 30
 Jun 2022 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135934.1799248-1-aahringo@redhat.com>
In-Reply-To: <20220630135934.1799248-1-aahringo@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jun 2022 09:34:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
Message-ID: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
Subject: Re: [RFC 0/2] refcount: attempt to avoid imbalance warnings
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000db535805e2acd76b"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000db535805e2acd76b
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> I send this patch series as RFC because it was necessary to do a kref
> change after adding __cond_lock() to refcount_dec_and_lock()
> functionality.

Can you try something like this instead?

This is two separate patches - one for sparse, and one for the kernel.

This is only *very* lightly tested (ie I tested it on a single kernel
file that used refcount_dec_and_lock())

                Linus

--000000000000db535805e2acd76b
Content-Type: text/x-patch; charset="US-ASCII"; name="sparse.patch"
Content-Disposition: attachment; filename="sparse.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l518xtgt0>
X-Attachment-Id: f_l518xtgt0

IGxpbmVhcml6ZS5jICAgICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tCiB2YWxp
ZGF0aW9uL2NvbnRleHQuYyB8IDE1ICsrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAz
NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbmVhcml6ZS5j
IGIvbGluZWFyaXplLmMKaW5kZXggZDlhZWQ2MWIuLjhkZDAwNWFmIDEwMDY0NAotLS0gYS9saW5l
YXJpemUuYworKysgYi9saW5lYXJpemUuYwpAQCAtMTUzNyw2ICsxNTM3LDggQEAgc3RhdGljIHBz
ZXVkb190IGxpbmVhcml6ZV9jYWxsX2V4cHJlc3Npb24oc3RydWN0IGVudHJ5cG9pbnQgKmVwLCBz
dHJ1Y3QgZXhwcmVzc2kKIAlhZGRfb25lX2luc24oZXAsIGluc24pOwogCiAJaWYgKGN0eXBlKSB7
CisJCXN0cnVjdCBiYXNpY19ibG9jayAqcG9zdF9jYWxsID0gTlVMTDsKKwogCQlGT1JfRUFDSF9Q
VFIoY3R5cGUtPmNvbnRleHRzLCBjb250ZXh0KSB7CiAJCQlpbnQgaW4gPSBjb250ZXh0LT5pbjsK
IAkJCWludCBvdXQgPSBjb250ZXh0LT5vdXQ7CkBAIC0xNTQ3LDggKzE1NDksMjEgQEAgc3RhdGlj
IHBzZXVkb190IGxpbmVhcml6ZV9jYWxsX2V4cHJlc3Npb24oc3RydWN0IGVudHJ5cG9pbnQgKmVw
LCBzdHJ1Y3QgZXhwcmVzc2kKIAkJCQlpbiA9IDA7CiAJCQl9CiAJCQlpZiAob3V0IDwgMCkgewot
CQkJCWNoZWNrID0gMDsKLQkJCQlvdXQgPSAwOworCQkJCXN0cnVjdCBiYXNpY19ibG9jayAqc2V0
X2NvbnRleHQ7CisJCQkJaWYgKHJldHZhbCA9PSBWT0lEKSB7CisJCQkJCXdhcm5pbmcoZXhwci0+
cG9zLCAibm9uc2Vuc2ljYWwgY29uZGl0aW9uYWwgb3V0cHV0IGNvbnRleHQgd2l0aCBubyBjb25k
aXRpb24iKTsKKwkJCQkJYnJlYWs7CisJCQkJfQorCQkJCWlmIChjaGVjayB8fCBpbikgeworCQkJ
CQl3YXJuaW5nKGV4cHItPnBvcywgIm5vbnNlbnNpY2FsIGNvbmRpdGlvbmFsIGlucHV0IGNvbnRl
eHQiKTsKKwkJCQkJYnJlYWs7CisJCQkJfQorCQkJCWlmICghcG9zdF9jYWxsKQorCQkJCQlwb3N0
X2NhbGwgPSBhbGxvY19iYXNpY19ibG9jayhlcCwgZXhwci0+cG9zKTsKKwkJCQlzZXRfY29udGV4
dCA9IGFsbG9jX2Jhc2ljX2Jsb2NrKGVwLCBleHByLT5wb3MpOworCQkJCWFkZF9icmFuY2goZXAs
IHJldHZhbCwgc2V0X2NvbnRleHQsIHBvc3RfY2FsbCk7CisJCQkJc2V0X2FjdGl2ZWJsb2NrKGVw
LCBzZXRfY29udGV4dCk7CisJCQkJb3V0ID0gLW91dDsKIAkJCX0KIAkJCWNvbnRleHRfZGlmZiA9
IG91dCAtIGluOwogCQkJaWYgKGNoZWNrIHx8IGNvbnRleHRfZGlmZikgewpAQCAtMTU2MCw2ICsx
NTc1LDExIEBAIHN0YXRpYyBwc2V1ZG9fdCBsaW5lYXJpemVfY2FsbF9leHByZXNzaW9uKHN0cnVj
dCBlbnRyeXBvaW50ICplcCwgc3RydWN0IGV4cHJlc3NpCiAJCQl9CiAJCX0gRU5EX0ZPUl9FQUNI
X1BUUihjb250ZXh0KTsKIAorCQlpZiAocG9zdF9jYWxsKSB7CisJCQlhZGRfZ290byhlcCwgcG9z
dF9jYWxsKTsKKwkJCXNldF9hY3RpdmVibG9jayhlcCwgcG9zdF9jYWxsKTsKKwkJfQorCiAJCWlm
IChjdHlwZS0+bW9kaWZpZXJzICYgTU9EX05PUkVUVVJOKQogCQkJYWRkX3VucmVhY2hhYmxlKGVw
KTsKIAl9CmRpZmYgLS1naXQgYS92YWxpZGF0aW9uL2NvbnRleHQuYyBiL3ZhbGlkYXRpb24vY29u
dGV4dC5jCmluZGV4IGI5NTAwZGM3Li5mODk2MmYxOSAxMDA2NDQKLS0tIGEvdmFsaWRhdGlvbi9j
b250ZXh0LmMKKysrIGIvdmFsaWRhdGlvbi9jb250ZXh0LmMKQEAgLTEwLDYgKzEwLDEwIEBAIHN0
YXRpYyB2b2lkIHIodm9pZCkgX19hdHRyaWJ1dGVfXygoY29udGV4dCgxLDApKSkKIAlfX2NvbnRl
eHRfXygtMSk7CiB9CiAKKy8vIE5lZ2F0aXZlIG91dHB1dCBtZWFucyAiY29uZGl0aW9uYWwgcG9z
aXRpdmUgb3V0cHV0IgorZXh0ZXJuIGludCBjb25kX2dldCh2b2lkKSBfX2F0dHJpYnV0ZSgoY29u
dGV4dCgwLC0xKSkpOworZXh0ZXJuIHZvaWQgbm9uc2Vuc2ljYWxfY29uZF9nZXQodm9pZCkgX19h
dHRyaWJ1dGUoKGNvbnRleHQoMCwtMSkpKTsKKwogZXh0ZXJuIGludCBfY2EoaW50IGZhaWwpOwog
I2RlZmluZSBjYShmYWlsKSBfX2NvbmRfbG9jayhfY2EoZmFpbCkpCiAKQEAgLTE5LDYgKzIzLDE3
IEBAIHN0YXRpYyB2b2lkIGdvb2RfcGFpcmVkMSh2b2lkKQogCXIoKTsKIH0KIAorc3RhdGljIHZv
aWQgZ29vZF9jb25kaXRpb25hbCh2b2lkKQoreworCWlmIChjb25kX2dldCgpKQorCQlyKCk7Cit9
CisKK3N0YXRpYyB2b2lkIG5vbnNlbnNpY2FsX2NvbmRpdGlvbmFsKHZvaWQpCit7CisJbm9uc2Vu
c2ljYWxfY29uZF9nZXQoKTsKK30KKwogc3RhdGljIHZvaWQgZ29vZF9wYWlyZWQyKHZvaWQpCiB7
CiAJYSgpOwo=
--000000000000db535805e2acd76b
Content-Type: text/x-patch; charset="US-ASCII"; name="kernel.patch"
Content-Disposition: attachment; filename="kernel.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l518xy841>
X-Attachment-Id: f_l518xy841

IGluY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCB8IDIgKysKIGluY2x1ZGUvbGludXgvcmVm
Y291bnQuaCAgICAgICB8IDYgKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5
cGVzLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgKaW5kZXggZDA4ZGZjYjBhYzY4
Li40ZjJhODE5ZmQ2MGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMu
aAorKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgKQEAgLTI0LDYgKzI0LDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIF9fY2hrX2lvX3B0cihjb25zdCB2b2xhdGlsZSB2b2lkIF9faW9t
ZW0gKnB0cikgeyB9CiAvKiBjb250ZXh0L2xvY2tpbmcgKi8KICMgZGVmaW5lIF9fbXVzdF9ob2xk
KHgpCV9fYXR0cmlidXRlX18oKGNvbnRleHQoeCwxLDEpKSkKICMgZGVmaW5lIF9fYWNxdWlyZXMo
eCkJX19hdHRyaWJ1dGVfXygoY29udGV4dCh4LDAsMSkpKQorIyBkZWZpbmUgX19jb25kX2FjcXVp
cmVzKHgpIF9fYXR0cmlidXRlX18oKGNvbnRleHQoeCwwLC0xKSkpCiAjIGRlZmluZSBfX3JlbGVh
c2VzKHgpCV9fYXR0cmlidXRlX18oKGNvbnRleHQoeCwxLDApKSkKICMgZGVmaW5lIF9fYWNxdWly
ZSh4KQlfX2NvbnRleHRfXyh4LDEpCiAjIGRlZmluZSBfX3JlbGVhc2UoeCkJX19jb250ZXh0X18o
eCwtMSkKQEAgLTUwLDYgKzUxLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fY2hrX2lvX3B0cihj
b25zdCB2b2xhdGlsZSB2b2lkIF9faW9tZW0gKnB0cikgeyB9CiAvKiBjb250ZXh0L2xvY2tpbmcg
Ki8KICMgZGVmaW5lIF9fbXVzdF9ob2xkKHgpCiAjIGRlZmluZSBfX2FjcXVpcmVzKHgpCisjIGRl
ZmluZSBfX2NvbmRfYWNxdWlyZXMoeCkKICMgZGVmaW5lIF9fcmVsZWFzZXMoeCkKICMgZGVmaW5l
IF9fYWNxdWlyZSh4KQkodm9pZCkwCiAjIGRlZmluZSBfX3JlbGVhc2UoeCkJKHZvaWQpMApkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yZWZjb3VudC5oIGIvaW5jbHVkZS9saW51eC9yZWZjb3Vu
dC5oCmluZGV4IGI4YTZlMzg3ZjhmOS4uYTYyZmNjYTk3NDg2IDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L3JlZmNvdW50LmgKKysrIGIvaW5jbHVkZS9saW51eC9yZWZjb3VudC5oCkBAIC0zNjEs
OSArMzYxLDkgQEAgc3RhdGljIGlubGluZSB2b2lkIHJlZmNvdW50X2RlYyhyZWZjb3VudF90ICpy
KQogCiBleHRlcm4gX19tdXN0X2NoZWNrIGJvb2wgcmVmY291bnRfZGVjX2lmX29uZShyZWZjb3Vu
dF90ICpyKTsKIGV4dGVybiBfX211c3RfY2hlY2sgYm9vbCByZWZjb3VudF9kZWNfbm90X29uZShy
ZWZjb3VudF90ICpyKTsKLWV4dGVybiBfX211c3RfY2hlY2sgYm9vbCByZWZjb3VudF9kZWNfYW5k
X211dGV4X2xvY2socmVmY291bnRfdCAqciwgc3RydWN0IG11dGV4ICpsb2NrKTsKLWV4dGVybiBf
X211c3RfY2hlY2sgYm9vbCByZWZjb3VudF9kZWNfYW5kX2xvY2socmVmY291bnRfdCAqciwgc3Bp
bmxvY2tfdCAqbG9jayk7CitleHRlcm4gX19tdXN0X2NoZWNrIGJvb2wgcmVmY291bnRfZGVjX2Fu
ZF9tdXRleF9sb2NrKHJlZmNvdW50X3QgKnIsIHN0cnVjdCBtdXRleCAqbG9jaykgX19jb25kX2Fj
cXVpcmVzKGxvY2spOworZXh0ZXJuIF9fbXVzdF9jaGVjayBib29sIHJlZmNvdW50X2RlY19hbmRf
bG9jayhyZWZjb3VudF90ICpyLCBzcGlubG9ja190ICpsb2NrKSBfX2NvbmRfYWNxdWlyZXMobG9j
ayk7CiBleHRlcm4gX19tdXN0X2NoZWNrIGJvb2wgcmVmY291bnRfZGVjX2FuZF9sb2NrX2lycXNh
dmUocmVmY291bnRfdCAqciwKIAkJCQkJCSAgICAgICBzcGlubG9ja190ICpsb2NrLAotCQkJCQkJ
ICAgICAgIHVuc2lnbmVkIGxvbmcgKmZsYWdzKTsKKwkJCQkJCSAgICAgICB1bnNpZ25lZCBsb25n
ICpmbGFncykgX19jb25kX2FjcXVpcmVzKGxvY2spOwogI2VuZGlmIC8qIF9MSU5VWF9SRUZDT1VO
VF9IICovCg==
--000000000000db535805e2acd76b--
