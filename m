Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6246DD24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbhLHUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbhLHUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:38:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+0igsjBn+gjIChauuW0uC5PhSbGo0FWg5AcsZL9+6dI=; b=yLVRr6KKxowpM1JvhvkILoTXIe
        jeRgY8PMkUjzXnJ/kKQyVPwyWlArFCFR0UWsxGQz2IlMcDu2RBBMJKQfEnw9QSZ/FuSpf+sTKxgzx
        FdaQmyiDJLiUpFg/EQof09k2qKU47v99A6K4msesqNI5g7lr160t721toGtKHUMIyeBqbGVnV/m8a
        OpJWlBPKC7Ao6qABCNV0enTNLUSA8swEsC4G6ZzsIwFYlewWbOzOHvlmnnEGPTczsV0FopwZfBWG0
        5VgPRzBQVI1QymgzaCgdjTGf3OEyYnlhn/uSSw0QZpQfzBVP9o4OhhmHsQLV0mdDyE4Qd6lXaqKFt
        mCOA9OeA==;
Received: from 54-240-197-234.amazon.com ([54.240.197.234] helo=u3832b3a9db3152.ant.amazon.com)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3ea-00EDFr-BT; Wed, 08 Dec 2021 20:35:04 +0000
Message-ID: <b9c4bcf345caa32996d7e439116058052ef1a367.camel@infradead.org>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
From:   David Woodhouse <dwmw2@infradead.org>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian <hejingxian@huawei.com>
Date:   Wed, 08 Dec 2021 20:35:00 +0000
In-Reply-To: <20211208190357.GX641268@paulmck-ThinkPad-P17-Gen-1>
References: <877dnedt7l.fsf@nanos.tec.linutronix.de>
         <87zh09tcqz.fsf@nanos.tec.linutronix.de>
         <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
         <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
         <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
         <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
         <0824902894565e850b79e494c38a7856f8358b99.camel@infradead.org>
         <f67ce85c73941bd5d35e8af84765c70f56ddcdf7.camel@infradead.org>
         <20211208173549.GU641268@paulmck-ThinkPad-P17-Gen-1>
         <9c5ad763b77543768b9b0e62aa238d62c47dbcb3.camel@infradead.org>
         <20211208190357.GX641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-DjYweF/YbGRHFaCstZf7"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DjYweF/YbGRHFaCstZf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-08 at 11:03 -0800, Paul E. McKenney wrote:
> On Wed, Dec 08, 2021 at 06:32:15PM +0000, David Woodhouse wrote:
> > On Wed, 2021-12-08 at 09:35 -0800, Paul E. McKenney wrote:
> > > On Wed, Dec 08, 2021 at 04:57:07PM +0000, David Woodhouse wrote:
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ef8d36f580fc..544198c674f2 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -4246,11 +4246,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > > > =20
> > > >  	rnp =3D rdp->mynode;
> > > >  	mask =3D rdp->grpmask;
> > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >=20
> > > If I am not too confused this morning, this can result in confusing
> > > lockdep splats because lockdep needs RCU to be watching the CPU
> > > acquiring the lock.  See the rcu_lockdep_current_cpu_online()
> > > function and is callers, with emphasis on lockdep_rcu_suspicious()
> > > and rcu_read_lock_held_common().
> >=20
> > Hm, OK. And it is the very act of setting rnp->ofl_seq & 1 which
> > triggers that, yes?
>=20
> Prevents that from triggering, but if I recall correctly, yes.

OK, thanks.

> > Ok, thanks. My initial hack of sticking my own spinlock around the
> > whole thing was also working for testing, but now I'm trying to clean
> > it up so I can post something for merging.
>=20
> Sounds good!
>=20
> You know, maybe it would be way easier to just create a new spinlock and
> use arch_spin_lock() to acquire it and arch_spin_unlock() to release it,
> bypassing lockdep for that one lock.  Then proceed as in your initial
> patch.

Hm. So... (summarising a little from IRC for the peanut gallery and our
own subsequent recollection) I had a play with doing an atomic
'acquire' for rnp->ofl_seq which is basically "spin until you can use
cmpxchg() to atomically increment it to an odd number".

http://david.woodhou.se/acquire-ofl-seq.patch

But *every* call to that 'acquire_ofl_seq() is paired with locking
rcu_state.ofl_lock, and *every* release is paired with unlocking
rcu_state.ofl_lock.

So I don't think I want a *new* lock; I think I want to use
arch_spin_lock on rcu_state.ofl_lock and expand it slightly (as in my
previous attempt to cover the modifications of rnp->ofl_seq.

Will throw that together and see what breaks...

> > > Though I are having some difficulty remembering why that wait loop in
> > > rcu_gp_init() needs to be there.  I am going to try removing it and
> > > seeing if rcutorture will be kind enough to remind me.  ;-)
> > >=20
> > > And it will of course be necessary to upgrade rcutorture to test
> > > concurrent CPU-online operations.  Will there be some sort of
> > > start-CPU-online function, or should I instead expect to need to
> > > provide multiple kthreads for onlining and an additional kthread
> > > for offliing?
> >=20
> > This is just at *boot* time, not runtime hotplug/unplug. We observed
> > that we spend quite a lot of time on a 96-way 2-socket Skylake system
> > just sending INIT to each CPU in turn, then waiting for it to be fully
> > online, then moving on to the next one. Hence doing them all in
> > parallel, which reduces the AP bringup time from about 300ms to 30ms.
> >=20
> > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/par=
allel-5.16
> >=20
>=20
> Nice win!!!
>=20
> And I do understand that you are only worried about boot speed, but
> adequate stress-testing of this will require run-time exercising of this.
> Yes, 30ms is fast, but you have other overheads when repeatedly rebooting=
,
> and so doing runtime tests will find bugs faster.

Absolutely!

> > > Huh.  I take it that concurrent online and offline is future work?
> > > Or does that need to work initially?
> >=20
> > Concurrent *online* (at boot) is the whole point. Those last two
> > commits currently in the branch linked above are the "oh crap, *that*
> > part doesn't work if you really let it happen concurrently, so let's
> > serialize them" hacks. In particular, the RCU one is=20
> > https://git.infradead.org/users/dwmw2/linux.git/commitdiff/5f4b77c9459c
> >=20
> >=20
> > And now I'm trying to come up with something a little less hackish :)
>=20
> Understood!  I am just trying to work out a decent validation plan for
> this.  Let's just say that changes in this area have not traditionally
> been boring.  ;-)
>=20
> > > More to the point, what are you using to stress-test this capability?
> >=20
> > Just boot. With lots of CPUs (and vCPUs in qemu, but even with a nice
> > fast parallel CPU bringup, Linux then spends the next 16 seconds
> > printing silly pr_info messages about KVM features so it isn't the most
> > exciting overall result right now)
> >=20
> > I confess I haven't actually tested runtime hotplug/unplug again
> > recently. I should do that ;)
>=20
> The rcutorture TREE03 scenario is rather aggressive about this.
> From the root of a recent Linux-kernel source tree:
>=20
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h con=
figs "TREE03" --trust-make
>=20
> Or, if you have a 64-CPU system:
>=20
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1h con=
figs "4*TREE03" --trust-make
>=20
> The latter would be a semi-credible smoke test for this sort of change.

Thanks.


--=-DjYweF/YbGRHFaCstZf7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEx
MjA4MjAzNTAwWjAvBgkqhkiG9w0BCQQxIgQgQS09VRcL9YOtsZtLVdthqZjnT5PL8PRXK4HFE8Jw
Lzswgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAAvlBAN+1wACBbDTiB5cvZlDEbv5GI+qqQVh2lA1LqVh4UyE+IdhNjSOOSP4LoGg
8WamNGO1/ewO4GU0jIjvdLn0huOlAyIsOk8ybJ3YiMTi8EpSiAQJBikGeusGVhDaCGyDVbKqlCQy
YdcKncIFulhvk5iHlHpeMojBDaz1fuCk41yYoIopBKkpe2jdO+2YguYOphT7vUYdZ+X7FwHRZGkj
yTMF2IChtw483UKGN4YdKNF9SQtnFCvaocukp/bZ96a0UBN+OOt5dDB96as1IgmUtcOno+L+WdLQ
65hKZ1im/NNQXNc/YU3MPzPV2Xgc3gh1FLp/JYdImUhAWat7u3sAAAAAAAA=


--=-DjYweF/YbGRHFaCstZf7--

