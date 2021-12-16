Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E689647688C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhLPDO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhLPDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:14:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E8FC061574;
        Wed, 15 Dec 2021 19:14:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so46956938lfv.4;
        Wed, 15 Dec 2021 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8ckiiPMBvsnpYvn/PbmVfcEnddoPyMOCAfOlq+kQHA=;
        b=c0FhMJVjEAcd5oUSI1BgUaNEPxuKnBfQDjzdaiyLy50G3qa3PrT/nNfzjz2gUAErpv
         gzkvUufdQVXXHdjE5uQU19clz18PQZPhXNoAxhLjblgsuvUMDy8GK4/mS9FJn6Le1MYj
         kT84I6gpMgwBWg1CEHVAtUAJgeWsnPyvjabQR3yZ9W1yhuFy57UmTP7zjt4ka17ZeXWy
         EfA4fvJUG5y+rqx7fWP9I3Qp3l7ZT8B9M7TdCgT6pcRxsdiVvothSCXAymSYRfUItRCf
         mlzE/U71njG9tNk7BtwjriOBiUDo0W4YpdY4pJ980aNORSeT0vVWABrNIUa3vW/IRDeE
         nZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8ckiiPMBvsnpYvn/PbmVfcEnddoPyMOCAfOlq+kQHA=;
        b=CuXeWT6h12c+zJgLoJfBBURoNlj5fIkVXE/XfVEvYxgm608r0K7UZERrwkZnT5HJYK
         5jRZPXTeFjbLA3oBJG0oRnNC/EgfKN6nlTiOHn3BMp0d3W2bF2xLd+LpgasA7ttlSY/h
         9LRK8FaKrQ1f4zymtm8MTrqcptz0mCeRozUK0nkwhv6A9Sz9fPrqQlA871lFaBhvQhC6
         Y1QX/Y9FgA3DvxMGxH9msNp4c4ZIjxUCL07XlY6iO+6tSfG0oUX5fYkhlw/4Z/TAilhv
         F/u2h1reo/lzeCBwygR3NkXZVWA0NuBBIVfZgB7JzOhSE4LWufCjz6tqs2fO+4G/MpwM
         E0pg==
X-Gm-Message-State: AOAM5300qpiFabOR/mcuo03j/WfwgsjGPuaH5wMX+wI5+TGUJ/zh8oiU
        cCXksZ2E6DOB4wHmrj/ciuEnE1TveV6nuOe+C+w=
X-Google-Smtp-Source: ABdhPJw1LAVcHOFwVzqutxZmdR6XrjWaQemxTXaA+zKjydgsC60bObDWCRvTFnL3ehHrR/un2fAyFPJzUzxSI36qucM=
X-Received: by 2002:a19:770a:: with SMTP id s10mr13668232lfc.234.1639624462078;
 Wed, 15 Dec 2021 19:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20211215030831.24058-1-trbecker@gmail.com> <CAGvGhF4y4ydeuQg9CmTF5OrrVmXG6D05PtBCWHb-EFmY8Y4zOA@mail.gmail.com>
In-Reply-To: <CAGvGhF4y4ydeuQg9CmTF5OrrVmXG6D05PtBCWHb-EFmY8Y4zOA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 15 Dec 2021 21:14:11 -0600
Message-ID: <CAH2r5msjUiD_4YUm-sJbmNC0ARk+qDd0JoY7c7f2Wm1qNJ6K2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cifs: sanitize multiple delimiters in prepath
To:     Leif Sahlberg <lsahlber@redhat.com>
Cc:     Thiago Rafael Becker <trbecker@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a10ae705d33ad1b5"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a10ae705d33ad1b5
Content-Type: text/plain; charset="UTF-8"

fixed various whitespace problems (pointed out by checkpatch), added
the suggested Acked-by, Fixes etc.
and tentatively merged into cifs-2.6.git for-next pending testing

See attached.

On Wed, Dec 15, 2021 at 1:49 PM Leif Sahlberg <lsahlber@redhat.com> wrote:
>
> Steve,
>
> Acked-by: me
> Steve, we should have this in stable
>
>     Fixes: 24e0a1eff9e2 ("cifs: switch to new mount api")
>     Cc: stable@vger.kernel.org # 5.11+
>
>
> On Wed, Dec 15, 2021 at 1:09 PM Thiago Rafael Becker <trbecker@gmail.com> wrote:
> >
> > mount.cifs can pass a device with multiple delimiters in it. This will
> > cause rename(2) to fail with ENOENT.
> >
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2031200
> > Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
> > ---
> >  fs/cifs/fs_context.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> > index 6a179ae753c1..4ce8a7df3a02 100644
> > --- a/fs/cifs/fs_context.c
> > +++ b/fs/cifs/fs_context.c
> > @@ -434,6 +434,34 @@ int smb3_parse_opt(const char *options, const char *key, char **val)
> >         return rc;
> >  }
> >
> > +/*
> > + * remove duplicate path delimiters. Windows is supposed to do that
> > + * but there are some bugs that prevent rename from working if there are
> > + * multiple delimiters.
> > + */
> > +void sanitize_path(char *path) {
> > +        char *pos = path, last = *path;
> > +        unsigned int offset = 0;
> > +
> > +        while(*(++pos)) {
> > +                if ((*pos == '/' || *pos == '\\') && (last == '/' || last == '\\')) {
> > +                        offset++;
> > +                        continue;
> > +                }
> > +
> > +                last = *pos;
> > +                *(pos - offset) = *pos;
> > +        }
> > +
> > +        pos = pos - offset - 1;
> > +
> > +        /* At this point, there should be only zero or one delimiter at the end of the string */
> > +        if (*pos != '/' && *pos != '\\')
> > +                pos++;
> > +
> > +        *pos = '\0';
> > +}
> > +
> >  /*
> >   * Parse a devname into substrings and populate the ctx->UNC and ctx->prepath
> >   * fields with the result. Returns 0 on success and an error otherwise
> > @@ -497,6 +525,8 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
> >         if (!ctx->prepath)
> >                 return -ENOMEM;
> >
> > +       sanitize_path(ctx->prepath);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.31.1
> >
>


-- 
Thanks,

Steve

--000000000000a10ae705d33ad1b5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-sanitize-multiple-delimiters-in-prepath.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-sanitize-multiple-delimiters-in-prepath.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kx8e1v3z0>
X-Attachment-Id: f_kx8e1v3z0

RnJvbSA4NTkwNTdjYzk3Y2M5NDliMDA5N2NkMWU3NzZhNjcwOGIzNjdlOTljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlhZ28gUmFmYWVsIEJlY2tlciA8dHJiZWNrZXJAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDE1IERlYyAyMDIxIDAwOjA4OjMxIC0wMzAwClN1YmplY3Q6IFtQQVRD
SF0gY2lmczogc2FuaXRpemUgbXVsdGlwbGUgZGVsaW1pdGVycyBpbiBwcmVwYXRoCgptb3VudC5j
aWZzIGNhbiBwYXNzIGEgZGV2aWNlIHdpdGggbXVsdGlwbGUgZGVsaW1pdGVycyBpbiBpdC4gVGhp
cyB3aWxsCmNhdXNlIHJlbmFtZSgyKSB0byBmYWlsIHdpdGggRU5PRU5ULgoKQnVnTGluazogaHR0
cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0yMDMxMjAwCkZpeGVzOiAy
NGUwYTFlZmY5ZTIgKCJjaWZzOiBzd2l0Y2ggdG8gbmV3IG1vdW50IGFwaSIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnICMgNS4xMSsKQWNrZWQtYnk6IFJvbm5pZSBTYWhsYmVyZyA8bHNhaGxi
ZXJAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhpYWdvIFJhZmFlbCBCZWNrZXIgPHRyYmVj
a2VyQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNy
b3NvZnQuY29tPgotLS0KIGZzL2NpZnMvZnNfY29udGV4dC5jIHwgMzAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2ZzL2NpZnMvZnNfY29udGV4dC5jIGIvZnMvY2lmcy9mc19jb250ZXh0LmMKaW5kZXgg
NmExNzlhZTc1M2MxLi40Y2U4YTdkZjNhMDIgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZnNfY29udGV4
dC5jCisrKyBiL2ZzL2NpZnMvZnNfY29udGV4dC5jCkBAIC00MzQsNiArNDM0LDM0IEBAIGludCBz
bWIzX3BhcnNlX29wdChjb25zdCBjaGFyICpvcHRpb25zLCBjb25zdCBjaGFyICprZXksIGNoYXIg
Kip2YWwpCiAJcmV0dXJuIHJjOwogfQogCisvKgorICogcmVtb3ZlIGR1cGxpY2F0ZSBwYXRoIGRl
bGltaXRlcnMuIFdpbmRvd3MgaXMgc3VwcG9zZWQgdG8gZG8gdGhhdAorICogYnV0IHRoZXJlIGFy
ZSBzb21lIGJ1Z3MgdGhhdCBwcmV2ZW50IHJlbmFtZSBmcm9tIHdvcmtpbmcgaWYgdGhlcmUgYXJl
CisgKiBtdWx0aXBsZSBkZWxpbWl0ZXJzLgorICovCit2b2lkIHNhbml0aXplX3BhdGgoY2hhciAq
cGF0aCkKK3sKKwljaGFyICpwb3MgPSBwYXRoLCBsYXN0ID0gKnBhdGg7CisJdW5zaWduZWQgaW50
IG9mZnNldCA9IDA7CisKKwl3aGlsZSAoKigrK3BvcykpIHsKKwkJaWYgKCgqcG9zID09ICcvJyB8
fCAqcG9zID09ICdcXCcpICYmIChsYXN0ID09ICcvJyB8fCBsYXN0ID09ICdcXCcpKSB7CisJCQlv
ZmZzZXQrKzsKKwkJCWNvbnRpbnVlOworCQl9CisJCWxhc3QgPSAqcG9zOworCQkqKHBvcyAtIG9m
ZnNldCkgPSAqcG9zOworCX0KKworCXBvcyA9IHBvcyAtIG9mZnNldCAtIDE7CisKKwkvKiBBdCB0
aGlzIHBvaW50LCB0aGVyZSBzaG91bGQgYmUgb25seSB6ZXJvIG9yIG9uZSBkZWxpbWl0ZXIgYXQg
dGhlIGVuZCBvZiB0aGUgc3RyaW5nICovCisJaWYgKCpwb3MgIT0gJy8nICYmICpwb3MgIT0gJ1xc
JykKKwkJcG9zKys7CisKKwkqcG9zID0gJ1wwJzsKK30KKwogLyoKICAqIFBhcnNlIGEgZGV2bmFt
ZSBpbnRvIHN1YnN0cmluZ3MgYW5kIHBvcHVsYXRlIHRoZSBjdHgtPlVOQyBhbmQgY3R4LT5wcmVw
YXRoCiAgKiBmaWVsZHMgd2l0aCB0aGUgcmVzdWx0LiBSZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQg
YW4gZXJyb3Igb3RoZXJ3aXNlCkBAIC00OTcsNiArNTI1LDggQEAgc21iM19wYXJzZV9kZXZuYW1l
KGNvbnN0IGNoYXIgKmRldm5hbWUsIHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCkKIAlpZiAo
IWN0eC0+cHJlcGF0aCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKKwlzYW5pdGl6ZV9wYXRoKGN0eC0+
cHJlcGF0aCk7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4zMi4wCgo=
--000000000000a10ae705d33ad1b5--
