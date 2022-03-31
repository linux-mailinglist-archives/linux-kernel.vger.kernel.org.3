Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178644EE116
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiCaSvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiCaSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3216E7D0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:50:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so763685lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVMNk6GWV9uKZbtiltf+Ubws//GzCYpeM+xQWjgBgmU=;
        b=FKN4TVK2kCdeNCIewyPYx+JDgSuvMr4oSBXC9xJtVrrvWvH2Oz3TYuovGCTGJaH92s
         IA+oj4ORy/EB1t0rlnDEnqEK2xCEvMm44jlVnZb8Vcqf9WBPWjOd/sGPm5SRuU7OHSA7
         frhaAO4TE0G1Jn7mIYu3WW9hfpj8rOxUYTCTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVMNk6GWV9uKZbtiltf+Ubws//GzCYpeM+xQWjgBgmU=;
        b=ueSsryM8uQuYSNd3DAdKMm80/DuIutNbRvHE1h7DjEmXXKZMrcxWBMJFC7LQInXGB/
         yoUB/JVyMHd+KsjZbTj9pTfXoJRG6yEAtkW1Nvv7dNxwUf71R/PUF7nXMv18dgsZOFWP
         UdrpOQKB6bEY1Wzk/24riKSMiOKcDIQd6uq+63gH8dItq4L+puIniT5tHVuqWcu3OQfE
         7uPPhjo7ldKf4Qzeiq0L6I5eFKWWNB+9mv/s4S2LCCH5cmMcVrER76FMjR3AgwQ+u9Lo
         e0bRa0GpcEG2ceSm35QoCC4FGvKfOvsk+vg+cXKvEcYyXSGTxHt4gVnBc1//tXCb2u9G
         5/cw==
X-Gm-Message-State: AOAM532gUmQBiezOmAjebJoNRjIB+IyN6+23bPJV25yFDDCwVFZzXr+o
        MogZOmkRQCfty13ELz5z5gXmYNrbmXxgTX83
X-Google-Smtp-Source: ABdhPJwvxoooS63QAw8xhWTQYfFkTM7V9pDG3tChfarCtpqSlUQTzjzOxJ7JnyyTjacglb3FoY+q2A==
X-Received: by 2002:a05:6512:3214:b0:44a:d39f:638f with SMTP id d20-20020a056512321400b0044ad39f638fmr1602365lfe.197.1648752601644;
        Thu, 31 Mar 2022 11:50:01 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d21-20020a056512321500b0044a23434568sm17447lfe.153.2022.03.31.11.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:49:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id k21so795134lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:49:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3ca1:b0:44a:93f1:45cf with SMTP id
 h33-20020a0565123ca100b0044a93f145cfmr11646111lfv.542.1648752598298; Thu, 31
 Mar 2022 11:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <202203311127.503A3110@keescook>
In-Reply-To: <202203311127.503A3110@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 11:49:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ0+9jBy6bm850h1jms1tja8xnon4X5v0LSO4biLhFGg@mail.gmail.com>
Message-ID: <CAHk-=wjQ0+9jBy6bm850h1jms1tja8xnon4X5v0LSO4biLhFGg@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
Content-Type: multipart/mixed; boundary="000000000000f2176c05db882026"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f2176c05db882026
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 31, 2022 at 11:35 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these hardening fixes for v5.18-rc1. This addresses an
> -Warray-bounds warning found under a few ARM defconfigs, and disables
> long-broken CONFIG_HARDENED_USERCOPY_PAGESPAN.

Can't we just remove that HARDENED_USERCOPY_PAGESPAN thing entirely?

Yes, yes, I know Matthew did that as part of other patches that is too
late to go in any more in this merge window, but just the removal
patch is a no-brainer.

IOW, why not just do the attached?

                    Linus

--000000000000f2176c05db882026
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1fcplxs0>
X-Attachment-Id: f_l1fcplxs0

IGFyY2gvcG93ZXJwYy9jb25maWdzL3NraXJvb3RfZGVmY29uZmlnIHwgIDEgLQogbW0vdXNlcmNv
cHkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiBzZWN1cml0eS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8IDEx
IC0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA3OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL3Bvd2VycGMvY29uZmlncy9za2lyb290X2RlZmNvbmZpZyBiL2FyY2gvcG93ZXJwYy9jb25m
aWdzL3NraXJvb3RfZGVmY29uZmlnCmluZGV4IGY0OTE4NzU3MDBlOC4uNjQxNzZjYzEyZDBlIDEw
MDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvY29uZmlncy9za2lyb290X2RlZmNvbmZpZworKysgYi9h
cmNoL3Bvd2VycGMvY29uZmlncy9za2lyb290X2RlZmNvbmZpZwpAQCAtMjc0LDcgKzI3NCw2IEBA
IENPTkZJR19OTFNfVVRGOD15CiBDT05GSUdfRU5DUllQVEVEX0tFWVM9eQogQ09ORklHX1NFQ1VS
SVRZPXkKIENPTkZJR19IQVJERU5FRF9VU0VSQ09QWT15Ci1DT05GSUdfSEFSREVORURfVVNFUkNP
UFlfUEFHRVNQQU49eQogQ09ORklHX0ZPUlRJRllfU09VUkNFPXkKIENPTkZJR19TRUNVUklUWV9M
T0NLRE9XTl9MU009eQogQ09ORklHX1NFQ1VSSVRZX0xPQ0tET1dOX0xTTV9FQVJMWT15CmRpZmYg
LS1naXQgYS9tbS91c2VyY29weS5jIGIvbW0vdXNlcmNvcHkuYwppbmRleCAyYzIzNWQ1YzIzNjQu
LjFhZDhjNzU1ODUwYiAxMDA2NDQKLS0tIGEvbW0vdXNlcmNvcHkuYworKysgYi9tbS91c2VyY29w
eS5jCkBAIC0xNTcsNzAgKzE1Nyw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19ib2d1c19h
ZGRyZXNzKGNvbnN0IHVuc2lnbmVkIGxvbmcgcHRyLCB1bnNpZ25lZCBsb25nIG4sCiAJCXVzZXJj
b3B5X2Fib3J0KCJudWxsIGFkZHJlc3MiLCBOVUxMLCB0b191c2VyLCBwdHIsIG4pOwogfQogCi0v
KiBDaGVja3MgZm9yIGFsbG9jcyB0aGF0IGFyZSBtYXJrZWQgaW4gc29tZSB3YXkgYXMgc3Bhbm5p
bmcgbXVsdGlwbGUgcGFnZXMuICovCi1zdGF0aWMgaW5saW5lIHZvaWQgY2hlY2tfcGFnZV9zcGFu
KGNvbnN0IHZvaWQgKnB0ciwgdW5zaWduZWQgbG9uZyBuLAotCQkJCSAgIHN0cnVjdCBwYWdlICpw
YWdlLCBib29sIHRvX3VzZXIpCi17Ci0jaWZkZWYgQ09ORklHX0hBUkRFTkVEX1VTRVJDT1BZX1BB
R0VTUEFOCi0JY29uc3Qgdm9pZCAqZW5kID0gcHRyICsgbiAtIDE7Ci0Jc3RydWN0IHBhZ2UgKmVu
ZHBhZ2U7Ci0JYm9vbCBpc19yZXNlcnZlZCwgaXNfY21hOwotCi0JLyoKLQkgKiBTb21ldGltZXMg
dGhlIGtlcm5lbCBkYXRhIHJlZ2lvbnMgYXJlIG5vdCBtYXJrZWQgUmVzZXJ2ZWQgKHNlZQotCSAq
IGNoZWNrIGJlbG93KS4gQW5kIHNvbWV0aW1lcyBbX3NkYXRhLF9lZGF0YSkgZG9lcyBub3QgY292
ZXIKLQkgKiByb2RhdGEgYW5kL29yIGJzcywgc28gY2hlY2sgZWFjaCByYW5nZSBleHBsaWNpdGx5
LgotCSAqLwotCi0JLyogQWxsb3cgcmVhZHMgb2Yga2VybmVsIHJvZGF0YSByZWdpb24gKGlmIG5v
dCBtYXJrZWQgYXMgUmVzZXJ2ZWQpLiAqLwotCWlmIChwdHIgPj0gKGNvbnN0IHZvaWQgKilfX3N0
YXJ0X3JvZGF0YSAmJgotCSAgICBlbmQgPD0gKGNvbnN0IHZvaWQgKilfX2VuZF9yb2RhdGEpIHsK
LQkJaWYgKCF0b191c2VyKQotCQkJdXNlcmNvcHlfYWJvcnQoInJvZGF0YSIsIE5VTEwsIHRvX3Vz
ZXIsIDAsIG4pOwotCQlyZXR1cm47Ci0JfQotCi0JLyogQWxsb3cga2VybmVsIGRhdGEgcmVnaW9u
IChpZiBub3QgbWFya2VkIGFzIFJlc2VydmVkKS4gKi8KLQlpZiAocHRyID49IChjb25zdCB2b2lk
ICopX3NkYXRhICYmIGVuZCA8PSAoY29uc3Qgdm9pZCAqKV9lZGF0YSkKLQkJcmV0dXJuOwotCi0J
LyogQWxsb3cga2VybmVsIGJzcyByZWdpb24gKGlmIG5vdCBtYXJrZWQgYXMgUmVzZXJ2ZWQpLiAq
LwotCWlmIChwdHIgPj0gKGNvbnN0IHZvaWQgKilfX2Jzc19zdGFydCAmJgotCSAgICBlbmQgPD0g
KGNvbnN0IHZvaWQgKilfX2Jzc19zdG9wKQotCQlyZXR1cm47Ci0KLQkvKiBJcyB0aGUgb2JqZWN0
IHdob2xseSB3aXRoaW4gb25lIGJhc2UgcGFnZT8gKi8KLQlpZiAobGlrZWx5KCgodW5zaWduZWQg
bG9uZylwdHIgJiAodW5zaWduZWQgbG9uZylQQUdFX01BU0spID09Ci0JCSAgICgodW5zaWduZWQg
bG9uZyllbmQgJiAodW5zaWduZWQgbG9uZylQQUdFX01BU0spKSkKLQkJcmV0dXJuOwotCi0JLyog
QWxsb3cgaWYgZnVsbHkgaW5zaWRlIHRoZSBzYW1lIGNvbXBvdW5kIChfX0dGUF9DT01QKSBwYWdl
LiAqLwotCWVuZHBhZ2UgPSB2aXJ0X3RvX2hlYWRfcGFnZShlbmQpOwotCWlmIChsaWtlbHkoZW5k
cGFnZSA9PSBwYWdlKSkKLQkJcmV0dXJuOwotCi0JLyoKLQkgKiBSZWplY3QgaWYgcmFuZ2UgaXMg
ZW50aXJlbHkgZWl0aGVyIFJlc2VydmVkIChpLmUuIHNwZWNpYWwgb3IKLQkgKiBkZXZpY2UgbWVt
b3J5KSwgb3IgQ01BLiBPdGhlcndpc2UsIHJlamVjdCBzaW5jZSB0aGUgb2JqZWN0IHNwYW5zCi0J
ICogc2V2ZXJhbCBpbmRlcGVuZGVudGx5IGFsbG9jYXRlZCBwYWdlcy4KLQkgKi8KLQlpc19yZXNl
cnZlZCA9IFBhZ2VSZXNlcnZlZChwYWdlKTsKLQlpc19jbWEgPSBpc19taWdyYXRlX2NtYV9wYWdl
KHBhZ2UpOwotCWlmICghaXNfcmVzZXJ2ZWQgJiYgIWlzX2NtYSkKLQkJdXNlcmNvcHlfYWJvcnQo
InNwYW5zIG11bHRpcGxlIHBhZ2VzIiwgTlVMTCwgdG9fdXNlciwgMCwgbik7Ci0KLQlmb3IgKHB0
ciArPSBQQUdFX1NJWkU7IHB0ciA8PSBlbmQ7IHB0ciArPSBQQUdFX1NJWkUpIHsKLQkJcGFnZSA9
IHZpcnRfdG9faGVhZF9wYWdlKHB0cik7Ci0JCWlmIChpc19yZXNlcnZlZCAmJiAhUGFnZVJlc2Vy
dmVkKHBhZ2UpKQotCQkJdXNlcmNvcHlfYWJvcnQoInNwYW5zIFJlc2VydmVkIGFuZCBub24tUmVz
ZXJ2ZWQgcGFnZXMiLAotCQkJCSAgICAgICBOVUxMLCB0b191c2VyLCAwLCBuKTsKLQkJaWYgKGlz
X2NtYSAmJiAhaXNfbWlncmF0ZV9jbWFfcGFnZShwYWdlKSkKLQkJCXVzZXJjb3B5X2Fib3J0KCJz
cGFucyBDTUEgYW5kIG5vbi1DTUEgcGFnZXMiLCBOVUxMLAotCQkJCSAgICAgICB0b191c2VyLCAw
LCBuKTsKLQl9Ci0jZW5kaWYKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIGNoZWNrX2hlYXBfb2Jq
ZWN0KGNvbnN0IHZvaWQgKnB0ciwgdW5zaWduZWQgbG9uZyBuLAogCQkJCSAgICAgYm9vbCB0b191
c2VyKQogewpAQCAtMjM5LDkgKzE3NSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19oZWFw
X29iamVjdChjb25zdCB2b2lkICpwdHIsIHVuc2lnbmVkIGxvbmcgbiwKIAlpZiAoZm9saW9fdGVz
dF9zbGFiKGZvbGlvKSkgewogCQkvKiBDaGVjayBzbGFiIGFsbG9jYXRvciBmb3IgZmxhZ3MgYW5k
IHNpemUuICovCiAJCV9fY2hlY2tfaGVhcF9vYmplY3QocHRyLCBuLCBmb2xpb19zbGFiKGZvbGlv
KSwgdG9fdXNlcik7Ci0JfSBlbHNlIHsKLQkJLyogVmVyaWZ5IG9iamVjdCBkb2VzIG5vdCBpbmNv
cnJlY3RseSBzcGFuIG11bHRpcGxlIHBhZ2VzLiAqLwotCQljaGVja19wYWdlX3NwYW4ocHRyLCBu
LCBmb2xpb19wYWdlKGZvbGlvLCAwKSwgdG9fdXNlcik7CiAJfQogfQogCmRpZmYgLS1naXQgYS9z
ZWN1cml0eS9LY29uZmlnIGIvc2VjdXJpdHkvS2NvbmZpZwppbmRleCA5YjJjNDkyNTU4NWEuLjdk
NjM5ZjFiMGM0YSAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvS2NvbmZpZworKysgYi9zZWN1cml0eS9L
Y29uZmlnCkBAIC0xNjMsMTcgKzE2Myw2IEBAIGNvbmZpZyBIQVJERU5FRF9VU0VSQ09QWQogCSAg
b3IgYXJlIHBhcnQgb2YgdGhlIGtlcm5lbCB0ZXh0LiBUaGlzIGtpbGxzIGVudGlyZSBjbGFzc2Vz
CiAJICBvZiBoZWFwIG92ZXJmbG93IGV4cGxvaXRzIGFuZCBzaW1pbGFyIGtlcm5lbCBtZW1vcnkg
ZXhwb3N1cmVzLgogCi1jb25maWcgSEFSREVORURfVVNFUkNPUFlfUEFHRVNQQU4KLQlib29sICJS
ZWZ1c2UgdG8gY29weSBhbGxvY2F0aW9ucyB0aGF0IHNwYW4gbXVsdGlwbGUgcGFnZXMiCi0JZGVw
ZW5kcyBvbiBIQVJERU5FRF9VU0VSQ09QWQotCWRlcGVuZHMgb24gQlJPS0VOCi0JaGVscAotCSAg
V2hlbiBhIG11bHRpLXBhZ2UgYWxsb2NhdGlvbiBpcyBkb25lIHdpdGhvdXQgX19HRlBfQ09NUCwK
LQkgIGhhcmRlbmVkIHVzZXJjb3B5IHdpbGwgcmVqZWN0IGF0dGVtcHRzIHRvIGNvcHkgaXQuIFRo
ZXJlIGFyZSwKLQkgIGhvd2V2ZXIsIHNldmVyYWwgY2FzZXMgb2YgdGhpcyBpbiB0aGUga2VybmVs
IHRoYXQgaGF2ZSBub3QgYWxsCi0JICBiZWVuIHJlbW92ZWQuIFRoaXMgY29uZmlnIGlzIGludGVu
ZGVkIHRvIGJlIHVzZWQgb25seSB3aGlsZQotCSAgdHJ5aW5nIHRvIGZpbmQgc3VjaCB1c2Vycy4K
LQogY29uZmlnIEZPUlRJRllfU09VUkNFCiAJYm9vbCAiSGFyZGVuIGNvbW1vbiBzdHIvbWVtIGZ1
bmN0aW9ucyBhZ2FpbnN0IGJ1ZmZlciBvdmVyZmxvd3MiCiAJZGVwZW5kcyBvbiBBUkNIX0hBU19G
T1JUSUZZX1NPVVJDRQo=
--000000000000f2176c05db882026--
