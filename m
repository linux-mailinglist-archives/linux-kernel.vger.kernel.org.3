Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285949EA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiA0Suq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:50:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:47043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbiA0Sup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643309437;
        bh=HeSwGIPUNuT3lbv+3W5Z+dz0XPpDJxu40TMVk5bJrP4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=MyRgrj7CPhp2n567jOw8qGoooissKiUyd0543+RWkZkKhiOAQupZAk7b6a6hnr2rj
         ULBLtVsb8MwcDHJ9rpSTQNH+uIFpxXospuLN208I/h7OoDJqwWc1XL//7c0aEcDkcg
         CXqij814ds3/2lqieqzSWnGyyIsc/1StWXzSqq9U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.136.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1mnDEg3v2U-00SB70; Thu, 27
 Jan 2022 19:50:37 +0100
Date:   Thu, 27 Jan 2022 19:49:26 +0100
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-csky@vger.kernel.org, linux-mm@kvack.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH v2] usercopy/csky: Do not fail on memory from former init
 sections
Message-ID: <YfLpNkmlvoR8iPcq@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:3CgDMPMCj2d7NrYEKDDE7lNJrzXYGNaSdzsN9/Sgon5u0chNi24
 tOfhFRMqqsn9TEb9nvqn+YrfotQ/CCRNIm0eYeq9dnKprYB6sJ5togG7VcnzEFNB5bytUru
 B9RG2kxoX77+DBMEJuESsC8iWKgRAcDKeGG9Oi0AFTxOyFdRp6KEqj5x5VVKeDpFGnHe93Y
 tlHcKvFjXATNJ4lcO+8FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnZ5MjFxWDo=:yTzcADo3/rHVx+vsg6Hx/G
 GJKL5TeZeu8C3GwDuRZTzR6WmfQzTYb8V0oguzxYxwddKuZDnp592AQpaRPexPwag8Yjctzmi
 nqWGNf6iFdtohHyinQGyokcqUgXCZBdda0TaW4yCprzqAZNhW3odI4w0BvCA6Qp6pkJSCpNWe
 RayB39ihg0K3Cvcrc/awEMiy3JKUwuMn5G7Zt0EGmS/G8J3ADuHdza4564hHn4F9e0/fpFZDC
 3t1onS/FyUcXgV6K6KxwH/PITWId3QHnOfOCDAmARRcsReyhNLy27Tg/a5VzXcvklTIBwJzb4
 4kFpDOJzVJB/pKjaG/xUNnh2QuzYaczzOX0i3K3Ir0x3iHDxfJfB7ypdjtYu0IkNhNUgNiWbH
 M6x42eEiLgZ/IwWIJjMo1HTKEJQqPVCRQ3Y3VogDcKsLx6NqyWrzH2TFbIGManovRXaPjnu0b
 K2USPPsdrbjlU7osLYrG04UboY8W2NG8X5p+EDXnB32Gw0LHMa7Qs8iv86HZ/lqfsoJtcHqe/
 Uf0NBpyRa0u1QbQg8VdXQMHJXamAqVdnnCMr4LkEioy1XNsNHXKgouaslkin/OseRYSwj/fu+
 GGUdAyWn5/38XSaEe86BzJ0XKiVVURRntMlKkT738w1QUjT0pcvwmisxElNfOQFQ+OkrI/ihq
 WfA9/5UdOnQhl+mpwEeq3SqxgiP6Mx92v+78ApZ4bivY+dIEtm9tusKT3RZR9nQ1T1hM8yywq
 KDka4iBHPGVsu1dNHLbiqrpkWRnudaR512b/S7gRIXqp3uarF20ftbqAmLz6lswDZRe0a8yaX
 cmSudiRnbHXoVb1K3WLkX7aTsdcPF2MaZdScNnb9Y/0P6C86BUd4BxlLRach4Lx40QhlRXsV0
 jRYgtyWP1imC6GsRPqZdPIVDo+eHdkulJ41SwCjK9DTezOvD9mLmwYSdbciTuAwJLx6ByO19W
 RQOXgpgbvo/UN9faKD7uBu71J5uOzZ0AHWPDM4w/NxB6PjW1QCLz9J7jtouy8WoWsiCXsaa29
 r/TkcXSHovr9WHVWQ23FNA89+kLuZv00/hMgN6WEyPa/UWW5LZwqMJI3jXuXSEl3/vYrIrG2L
 fhWDEkMdk7mUA0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the parisc port I suddenly noticed that with
HARDENED_USERCOPY=3Dy the usercopy checks randomly reported errors which e=
ven
prevented the kernel to boot into userspace.

Specifically the function check_kernel_text_object() reported those errors=
, as
it thought the kernel variable I was using belongs to the kernel text area=
, and
as such was invalid to be used.

Looking at the code you'll see that check_kernel_text_object() checks
if the given pointer is inside the _stext to _etext memory area:

/* Is this address range in the kernel text area? */
static inline void check_kernel_text_object(const unsigned long ptr, unsig=
ned long n, bool to_user)
{
        unsigned long textlow =3D (unsigned long)_stext;
        unsigned long texthigh =3D (unsigned long)_etext;

        if (overlaps(ptr, n, textlow, texthigh))
                usercopy_abort("kernel text", NULL, to_user, ptr - textlow=
, n);
}

When I faced the issues on parisc, the parisc kernel memory layout in
vmlinux.lds.S file was the following (it isn't any longer because of commi=
t
98400ad75e95):

        _stext =3D .;
        __init_begin =3D .;
        HEAD_TEXT_SECTION
        INIT_DATA_SECTION(PAGE_SIZE)
        __init_end =3D .;

        _text =3D .;              /* Text and read-only data */
        .text ALIGN(PAGE_SIZE) : {
                TEXT_TEXT
                LOCK_TEXT
	...
	_etext =3D .;

As can be seen, the INIT sections are inside the _stext ... _etext section=
,
and this is important: On parisc the init sections can be quite big when
HUGE_PAGES are enabled and as such triggers the problem more frequently.

Now, after bootup all architectures call free_initmem() which frees up the=
 INIT
section, so the former INIT memory area can be used by the kernel for kmal=
loc()
or similiar allocations.

Now, when starting to execute userspace the parisc kernel allocated memory=
 to
interact with userspace, and sometimes - by accident - some of that memory=
 was
allocated from the former INIT section.

By using copy_to_user() and copy_from_user() the hardened usercopy checks =
were
executed and they then triggered the failure in the check_kernel_text_obje=
ct()
function in case such memory from the INIT section was used. The problem i=
s,
that check_kernel_text_object() currently ignores that the INIT section (w=
hich
is now OK to be used) *might* be inside the _stext ...  _etext area.

On parisc I fixed this issue by moving the _stext symbol behind the INIT s=
ection.

I checked the vmlinux.lds.S files of the other architectures and I do beli=
eve that
the sky architecture is still suffering from this problem (maybe unnoticed=
 yet,
because it may happen very seldom/randomly and depending on the size of th=
e INIT
sections).

The current csky vmlinux.lds.S file looks like this:

        _stext =3D .;
        __init_begin =3D .;
        INIT_TEXT_SECTION(PAGE_SIZE)
        INIT_DATA_SECTION(PAGE_SIZE)
        __init_end =3D .;
        .text : AT(ADDR(.text) - LOAD_OFFSET) {
...
        } =3D 0
        _etext =3D .;

So, for csky I think the _stext symbol needs to be moved after the __init_=
end
symbol to prevent the userchecks to trigger.

The other (and in my opinion better) solution is to generally enhance the
usercopy check in check_kernel_text_object() like it's proposed in the pat=
ch
below.

Helge

=2D-----------------

The memory area between the _stext and the _etext symbols may include the =
init
sections. Currently this is true for the csky architecture only.
If the init sections are freed after bootup, the kernel may reuse this mem=
ory.

In one test the usercopy checks if a given kernel address is inside the .t=
ext
section (from _stext to _etext), and it then wrongly fails if the memory i=
s
from the former init sections.

Fix this potential failure by first checking against the init sections bef=
ore
checking against the _stext/_etext section.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/mm/usercopy.c b/mm/usercopy.c
index b3de3c4eefba..37a35c6051bc 100644
=2D-- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -113,6 +113,15 @@ static bool overlaps(const unsigned long ptr, unsigne=
d long n,
 	return true;
 }

+static bool inside_init_area(const unsigned long ptr, unsigned long n,
+		char *start, char *end)
+{
+	unsigned long initlow =3D (unsigned long) start;
+	unsigned long inithigh =3D (unsigned long) end;
+
+	return (ptr >=3D initlow && (ptr + n) < inithigh);
+}
+
 /* Is this address range in the kernel text area? */
 static inline void check_kernel_text_object(const unsigned long ptr,
 					    unsigned long n, bool to_user)
@@ -121,6 +130,12 @@ static inline void check_kernel_text_object(const uns=
igned long ptr,
 	unsigned long texthigh =3D (unsigned long)_etext;
 	unsigned long textlow_linear, texthigh_linear;

+	/* Ok if inside the former init sections */
+	if (inside_init_area(ptr, n, __init_begin, __init_end))
+		return;
+	if (inside_init_area(ptr, n, _sinittext, _einittext))
+		return;
+
 	if (overlaps(ptr, n, textlow, texthigh))
 		usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);

