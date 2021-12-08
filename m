Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAAC46D682
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhLHPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhLHPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:14:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F28C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BvI2r2nmkuUeRh7MbSaFiVCo7hpE21ktfhjPm6XX8SI=; b=qYHGk7n+lK/oMeUeeZ3ehI4udr
        5tnKSqcjHfK/Won9yninC8uSgDVc3Y2ch5w3oUYRUSO/gqbstwq5JRDt/Vhbq+7BMzsrQ8JkczjOP
        ty6TTISvkTOkCktNvHaHKOirq0jzq0Oj3v59c5WLOatWD8SurodTn5c0c3F2l06tbSVwihqAXS9L7
        DLtOZ2GVa/qS6xdbaBRpCl9i+5HSvtL6Z1S8cTTEx62GuOfVW0ih22XATsmHGIgdslKc5n7sZLhgt
        PftQ3aDp5wlpQkObTlydmWkgMtxkky39kYQ4y3R8R6agRXnTvtrfG40qxSn2O0/rQZWfTcDmT534r
        wutMAdsw==;
Received: from 54-240-197-234.amazon.com ([54.240.197.234] helo=u3832b3a9db3152.ant.amazon.com)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muyaz-00D6jy-Df; Wed, 08 Dec 2021 15:11:01 +0000
Message-ID: <0824902894565e850b79e494c38a7856f8358b99.camel@infradead.org>
Subject: Re: [PATCH] use x86 cpu park to speedup smp_init in kexec situation
From:   David Woodhouse <dwmw2@infradead.org>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "shenkai (D)" <shenkai8@huawei.com>,
        "Schander, Johanna 'Mimoja' Amelie" <mimoja@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        luolongjun@huawei.com, hejingxian <hejingxian@huawei.com>
Date:   Wed, 08 Dec 2021 15:10:57 +0000
In-Reply-To: <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
References: <87ft22dxop.fsf@nanos.tec.linutronix.de>
         <27357c74bdc3b52bdf59e6f48cd8690495116d64.camel@infradead.org>
         <877dnedt7l.fsf@nanos.tec.linutronix.de>
         <87zh09tcqz.fsf@nanos.tec.linutronix.de>
         <1d2a7bc911da2bbaa4c441d269287fbb5b1bc8d7.camel@infradead.org>
         <5039f6178715dc4725a8c7f071dfd9ef5d70ae43.camel@infradead.org>
         <d7939a95731de8b8eb9245c330f014772e40f145.camel@infradead.org>
         <20211208145047.GR641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-YoVeuXXPaFNfPDWfYtLQ"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YoVeuXXPaFNfPDWfYtLQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-12-08 at 06:50 -0800, Paul E. McKenney wrote:
> On Wed, Dec 08, 2021 at 02:14:35PM +0000, David Woodhouse wrote:
> > > Actually it breaks before that, in rcu_cpu_starting(). A spinlock
> > > around that, an atomic_t to let the APs do their TSC sync one at a ti=
me
> > > (both in the above tree now), and I have a 75% saving on CPU bringup
> > > time for my 28-thread Haswell:
> >=20
> > Coming back to this, I've updated it and thrown up a new branch at=20
> > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/par=
allel-5.16
> >=20
> >=20
> > For those last two fixes I had started with a trivial na=C3=AFve approa=
ch of
> > just enforcing serialization.
> >=20
> > I'm sure we can come up with a cleverer 1:N way of synchronizing the
> > TSCs, instead of just serializing the existing 1:1 sync.
> >=20
> > For rcu_cpu_starting() I see there's *already* a lock in the
> > rcu_node... could we use that same lock to protect the manipulation of
> > rnp->ofl_seq and allow rcu_cpu_starting() to be invoked by multiple APs
> > in parallel? Paul?
> >=20
> > On a related note, are you currently guaranteed that rcu_report_dead()
> > cannot be called more than once in parallel? Might you want the same
> > locking there?
>=20
> Just to make sure I understand, the goal here is to bring multiple CPUs
> online concurrently, correct?  If so, this will take some digging to
> check up on the current implicit assumptions about CPU-hotplug operations
> being serialized.  Some of which might even be documented.  ;-)

Indeed. All the APs end up calling rcu_cpu_starting() at the same time,
and bad things happen. So I took the na=C3=AFve "stick a lock around it"
approach and the problem went away:

commit 60984965ac1945446eb23ff5a87a4c7acc821409
Author: David Woodhouse <dwmw@amazon.co.uk>
Date:   Tue Feb 16 15:04:34 2021 +0000

    rcu: Add locking around rcu_cpu_starting()
   =20
    To allow architectures to bring APs online in parallel, we need locking
    around rcu_cpu_starting(). Perhaps we could use the existing node
    spinlock... Paul?
   =20
    Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ef8d36f580fc..5816d3d40c6c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4231,6 +4231,8 @@ int rcutree_offline_cpu(unsigned int cpu)
  * from the incoming CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
  */
+static DEFINE_RAW_SPINLOCK(rcu_startup_lock);
+
 void rcu_cpu_starting(unsigned int cpu)
 {
        unsigned long flags;
@@ -4239,9 +4241,11 @@ void rcu_cpu_starting(unsigned int cpu)
        struct rcu_node *rnp;
        bool newcpu;
=20
+       raw_spin_lock(&rcu_startup_lock);
+
        rdp =3D per_cpu_ptr(&rcu_data, cpu);
        if (rdp->cpu_started)
-               return;
+               goto out;
        rdp->cpu_started =3D true;
=20
        rnp =3D rdp->mynode;
@@ -4273,6 +4277,8 @@ void rcu_cpu_starting(unsigned int cpu)
        WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
        WARN_ON_ONCE(rnp->ofl_seq & 0x1);
        smp_mb(); /* Ensure RCU read-side usage follows above initializatio=
n. */
+ out:
+       raw_spin_unlock(&rcu_startup_lock);
 }
=20
 /*


On coming back to this and trying to work out the *correct* fix, I see
that there's already a per-node spinlock covering most of this
function, and I strongly suspect that the better fix is as simple as
expanding the coverage of the existing lock? But I have questions...

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4246,11 +4246,11 @@ void rcu_cpu_starting(unsigned int cpu)
=20
        rnp =3D rdp->mynode;
        mask =3D rdp->grpmask;
+       raw_spin_lock_irqsave_rcu_node(rnp, flags);
        WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
        WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
        rcu_dynticks_eqs_online();
        smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
-       raw_spin_lock_irqsave_rcu_node(rnp, flags);
        WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
        newcpu =3D !(rnp->expmaskinitnext & mask);
        rnp->expmaskinitnext |=3D mask;
@@ -4266,13 +4266,13 @@ void rcu_cpu_starting(unsigned int cpu)
                rcu_disable_urgency_upon_qs(rdp);
                /* Report QS -after- changing ->qsmaskinitnext! */
                rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-       } else {
-               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+               /* Er, why didn't we drop the lock here? */
        }
        smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
        WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
        WARN_ON_ONCE(rnp->ofl_seq & 0x1);
        smp_mb(); /* Ensure RCU read-side usage follows above initializatio=
n. */
+       raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
=20
 /*



> But first...  Is it just bringing CPUs online that is to happen
> concurrently?  Or is it also necessary to take CPUs offline concurrently?

Yes. That is: *First*, it is just bringing CPUs online that is to
happen concurrently. :)

As for offlining.... well, if the cpuhp code didn't intentionally
guarantee that your existing rcu_report_dead() function can only be
called once at a time, and you are only relying on the fact that
*empirically* that seems to be the case, then you are naughty and
should give it the same kind of locking we speak of above.

And although I don't currently have designs on parallel offlining, ask
me again after I've audited the kexec code and seen how long it takes
to do that in series (if it's properly offlining them at all).=20

--=-YoVeuXXPaFNfPDWfYtLQ
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
MjA4MTUxMDU3WjAvBgkqhkiG9w0BCQQxIgQg2C+Pkz3UsHesw5vKS66O7R0Tom+nwXRS3uUmhi7o
Ug4wgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAKAlkL4fPfiBFzT196H++WB4Mj+w5QqNOX7I2RtdWMot+J6eAUS2ndCj7BDK7DCB
LYKBSSEgCqJIDVRDurDGsJoC/qoPJNEPViVcyFFX+1sDos40zO/sJT8BpTJFOXpMixhvBgojjxhj
viRspV9yfOh04InRE8EFOavEcpQVVz2i3elzFzYjI0Dcuc/vttf/cE9vi8D9JiKnHp6gnUhWHjWH
bkK3iIRmngKhtTe5Hz1CQtxxq/jbbWfk9mHbDQXy6Uj+n8yQISOn7TSIfcHPGFAbfqq9TK65vxAv
+9Y6jkSssXpx83poNDOpfwNMG6VbpoUzsROQam5ghvyg+etREb8AAAAAAAA=


--=-YoVeuXXPaFNfPDWfYtLQ--

