Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF7585F89
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiGaPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiGaPkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:40:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D9E0B7;
        Sun, 31 Jul 2022 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659282043;
        bh=455S/Bkj5h1lhx7w4Mij9eRLCCdj/4iqM8wDFPcFhCM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NFlRiovXy0GgdVPuUpLt67qY8MU84md/BZNItSXoBguhHZOvn8If7IirUAKvxSaVu
         gpEguDFV0yJ2C877qBsfwcbndT3D7giDHmRpvIwvicl0v6V6wmResOWjjSlSao2Mn0
         kjH119DdM8lD/xBHIq/vdbZQiwXp061Ni3ARD7HI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.152.171]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1nK8PI3ooU-012ZD5; Sun, 31
 Jul 2022 17:40:42 +0200
Message-ID: <f15c9525-f21f-0599-3d5e-d9cbedc683df@gmx.de>
Date:   Sun, 31 Jul 2022 17:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Content-Language: en-US
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de>
 <7973ec94-75ad-c133-032e-b83beeb2d397@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <7973ec94-75ad-c133-032e-b83beeb2d397@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:96yvlOFnhb0Fhsfp3e8feRiz+vkd/lOpKVQiIsvZ7ADJ/vfiTlE
 sv1+YusSs1DbLM+HH+bjQV/ZaxYU3s8okby6K3SeCyrQtBWYw0lc1cXaAvzzh2LoDxQvoYv
 ayWZ3b6yHzVn+mLXVGiSzgEBDhLvX4p/1fYzRcWwh/+rRdFVtnWNXh5ZKVmWUuvyxzJfd0l
 yydudPuCmcECITggoAMEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CFsMDRFMyVw=:RB3RzDSdrRMy03tR8sL+38
 IbZ1dn/xAFlJwTxDMfDR3hcFmjopEPG2IJLu9Lec2fnW+sWOvHanpxDXlEuQHjMhIIuz6VFUm
 csaKje/Xlo3NhTOGxPS9Kj9S/B02tp/fVTDcZs/+r6WS6wnmot+LlBWuN8B7p0lEwGBD/fSUI
 bDA4nJU2WWN9IQStAjGewuORNamggH0EGGSVT2KTCgJN4hj7s3XWqgH+KyajgJmHEeGN//6b1
 Dw6gTm9kNJHG/cuLAWdRMNqKtsvodj9iGDgKF3BoNC7ICAeuDC0h+QmDzuH11ksXs26HRxRz9
 NEmHzJ/0Rf4PmlBPB+xswSBj77c/XUhPCrvlKZ5O3ddfo23HZnkM/1MwDjK6h5N2WPbAv4JFM
 k6qegwmgc1UFg5AOIrBe0oKtwEtJJUgCoyy43yt9YTmdfTvEj8bIlfuhqwxF6JMlIJmLWvppf
 B2dwMriufZ06hWwY563clEghpL2lqHsOP35lNvh8GZVM66l+qi492RBW7+N+m6Wk4CZGLT0hb
 gVb9GY4G8mOhP4XRWowmLnZ4fIlnApNzSKh9QfLczXID+IODzzYCoq1wo7sLYLPiWxYKgrfWP
 kEuZyQBvrc0/dMNWd8gyqkldhmluQ0iJVk0yOfkitZ5ELkmo/pyDloUs1B/0wGXzySg71cjfn
 FAtb2hEYCZMxv1454CA8i1NtS5sCJCjGz1HiR4YtEtjcpgsmfECfTlHXbDmYKY+VJG0W2hd8m
 2vPQ0M5M6LRohDwRH0xjh8Go4lY3SXbkqmRADss3xVMkIRnFxUeJMfBpRMZMu1ZnQjlh388WC
 e7bWVFmRtKZYiuEz7obaQ62WfaFWADe/+Ba7EOvxqL+5/aU+Wz86KWp3UHZGuCjt+VEQ10Ks7
 gm1EuiA0HQ+HOuSt/e6fMfH3NpbMG1ZAxDigDbTHaMOKd4PoouOLxfme9XNL4M3r6YWO0DGmq
 h5AjgE5pSRgOe2CPJRPPJ7ZVwpWRk5opQpGtSP6J9ghuI9bT55W2ElFKq+LAWDhTbRSZKgBK3
 B6xAtChImvGubPHIic4HeamPqtMMUiZHUcR5kwjApQ1pLYEPI9vWkulhwylRdNpLcTVTSEwp2
 0OZdVxokXSICt/wgu7RXWLPC9rkP5xurrY8UUQ+A63I4lyXQ7rlHzjdxg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/22 15:55, Khalid Masum wrote:
> On 7/30/22 23:25, Helge Deller wrote:
>> On 7/29/22 08:51, Khalid Masum wrote:
>>> Here is a simplified reproducer for the issue:
>>>
>>> https://gist.githubusercontent.com/Labnann/923d6b9b3a19848fc129637b839=
b8a55/raw/a68271fcc724569735fe27f80817e561b3ff629a/reproducer.c
>>
>> The reproducer does this:
>> ioctl(3, TIOCLINUX, TIOCL_SETSEL, selection: xs:3=C2=A0 ys:0=C2=A0 xe:0=
 ye:0 mode:0)=C2=A0 =3D 0
>> -> sets the text selection area
>> ioctl(4, KDFONTOP)=C2=A0 with op=3D0 (con_font_set), charcount=3D512=C2=
=A0 width=3D8=C2=A0 height=3D32, 0x20000000) =3D 0
>> -> changes the font size.
>>
>> It does not crash with current Linus' head (v5.19-rc8).
>> Kernel v5.16, which was used by this KASAN report, hasn't received back=
ports
>> since months, so I tried stable kernel v5.15.58 instead, and this
>> kernel crashed with the reproducer.
>>
>> The reproducer brings up two issues with current code:
>> 1. The reproducer uses ioctl(TIOCLINUX, TIOCL_SETSEL) and hands over (i=
nvalid)
>> zero-values for ys and ye for the starting lines.
>> This is wrong, since the API seems to expect a "1" as the very first li=
ne for the selection.
>
> Why do you think that API expects a 1?

because the code in drivers/tty/vt/selection.c indicates this:
See:
static int vc_selection(struct vc_data *vc, struct tiocl_selection *v, str=
uct tty_struct *tty)
{
        int ps, pe;
...
        v->xs =3D min_t(u16, v->xs - 1, vc->vc_cols - 1);
        v->ys =3D min_t(u16, v->ys - 1, vc->vc_rows - 1);
        v->xe =3D min_t(u16, v->xe - 1, vc->vc_cols - 1);
        v->ye =3D min_t(u16, v->ye - 1, vc->vc_rows - 1);
...
        ps =3D v->ys * vc->vc_size_row + (v->xs << 1);
        pe =3D v->ye * vc->vc_size_row + (v->xe << 1);

The userspace-provided xs,ys,xe and ye values are decremented by one
before ps and pe (the pointers into the text screen array) are calculated.
So, for the xs...ye values in the range from 1..max-screen-lines/columns
are expected.

Helge
