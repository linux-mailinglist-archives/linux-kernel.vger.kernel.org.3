Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E64D690D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351081AbiCKTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiCKTV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:21:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6381884;
        Fri, 11 Mar 2022 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1MNIGj+KFYZG9aGwrBZTTH39NuRFX1gyJctTHRiY/k=; b=fvXRlXcGfl/VX/YthinvXJg1hk
        h19PZCHCvRYF1ozQuWq3u9FNwYV85s9hhqx73y9M/usi2qnDBkySmj8IDj/PoPNCZE3/g1KZMz/jk
        hzd6Ygvi5cptER9ujtfszby5tUymex/OiOaY/MRN5rvV5USxUrKO7IzkXCiO8FsfQu2YAeSMklBpD
        dXhT9D90e3kghbuzKLieDTLNRXpHjOcjepT6EbyiMWj77rdj5jv/3aD+6vMDjLRhn1HC8QvgRnsos
        xUnqvK4QJrKb99HG8jSdDLyEtUyetLFb8tMvyGvsiSZJEJ5AB80xPpq/wrtMEbn3T+NdH1MosgyA2
        ux2f1uyw==;
Received: from [2001:8b0:10b:1::3ae] (helo=u3832b3a9db3152.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSkoD-001qkO-VK; Fri, 11 Mar 2022 19:20:18 +0000
Message-ID: <9099d8903e9b2b16daec712acc9aa533fe84d102.camel@infradead.org>
Subject: [PATCH] PM / hibernate: Honour ACPI hardware signature by default
 for virtual guests
From:   David Woodhouse <dwmw2@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        benh <benh@kernel.crashing.org>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        Amit Shah <aams@amazon.com>
Date:   Fri, 11 Mar 2022 19:20:17 +0000
In-Reply-To: <CAJZ5v0gAkOqh1LVpdXKLxpswBSG-3LUaXoZgw0Op+3V69BjhZQ@mail.gmail.com>
References: <26decf155bffc021a97846c0a0ed09c2b5e0bef1.camel@infradead.org>
         <CAJZ5v0gAkOqh1LVpdXKLxpswBSG-3LUaXoZgw0Op+3V69BjhZQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-CmcjR5l3dQwM1q5C/6/2"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CmcjR5l3dQwM1q5C/6/2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The ACPI specification says that OSPM should refuse to restore from
hibernate if the hardware signature changes, and should boot from
scratch. However, real BIOSes often vary the hardware signature in cases
where we *do* want to resume from hibernate, so Linux doesn't follow the
spec by default.

However, in a virtual environment there's no reason for the VMM to vary
the hardware signature *unless* it wants to trigger a clean reboot as
defined by the ACPI spec. So enable the check by default if a hypervisor
is detected.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---

On Wed, 2021-12-08 at 16:07 +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 8, 2021 at 5:09 PM David Woodhouse <dwmw2@infradead.org> wrot=
e:
> > A follow-up patch may do this automatically for certain "known good"
> > machines based on a DMI match, or perhaps just for all hypervisor
> > guests since there's no good reason a hypervisor would change the
> > hardware_signature that it exposes to guests *unless* it wants them
> > to obey the ACPI specification.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Applied as 5.17 material, sorry for the delay.

Here's the threatened follow-up. I think that a blanket enablement for
all hypervisors is sane enough; there's no reason why a virtual
environment would vary the hardware signature *unless* it wanted to
trigger the ACPI defined hibernate behaviour, is there?

 arch/x86/kernel/acpi/sleep.c | 23 +++++++++++++++++++++--
 drivers/acpi/sleep.c         | 11 +++--------
 include/linux/acpi.h         |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 1e97f944b47d..3b7f4cdbf2e0 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -15,6 +15,7 @@
 #include <asm/desc.h>
 #include <asm/cacheflush.h>
 #include <asm/realmode.h>
+#include <asm/hypervisor.h>
=20
 #include <linux/ftrace.h>
 #include "../../realmode/rm/wakeup.h"
@@ -140,9 +141,9 @@ static int __init acpi_sleep_setup(char *str)
 			acpi_realmode_flags |=3D 4;
 #ifdef CONFIG_HIBERNATION
 		if (strncmp(str, "s4_hwsig", 8) =3D=3D 0)
-			acpi_check_s4_hw_signature(1);
+			acpi_check_s4_hw_signature =3D 1;
 		if (strncmp(str, "s4_nohwsig", 10) =3D=3D 0)
-			acpi_check_s4_hw_signature(0);
+			acpi_check_s4_hw_signature =3D 0;
 #endif
 		if (strncmp(str, "nonvs", 5) =3D=3D 0)
 			acpi_nvs_nosave();
@@ -160,3 +161,21 @@ static int __init acpi_sleep_setup(char *str)
 }
=20
 __setup("acpi_sleep=3D", acpi_sleep_setup);
+
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_HYPERVISOR_GUEST)
+static int __init init_s4_sigcheck(void)
+{
+	/*
+	 * If running on a hypervisor, honour the ACPI specification
+	 * by default and trigger a clean reboot when the hardware
+	 * signature in FACS is changed after hibernation.
+	 */
+	if (acpi_check_s4_hw_signature =3D=3D -1 &&
+	    !hypervisor_is_type(X86_HYPER_NATIVE))
+		acpi_check_s4_hw_signature =3D 1;
+
+	return 0;
+}
+/* This must happen before acpi_init() which is a subsys initcall */
+arch_initcall(init_s4_sigcheck);
+#endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index a60ff5dfed3a..4c498e1051e9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -874,12 +874,7 @@ static inline void acpi_sleep_syscore_init(void) {}
 #ifdef CONFIG_HIBERNATION
 static unsigned long s4_hardware_signature;
 static struct acpi_table_facs *facs;
-static int sigcheck =3D -1; /* Default behaviour is just to warn */
-
-void __init acpi_check_s4_hw_signature(int check)
-{
-	sigcheck =3D check;
-}
+int acpi_check_s4_hw_signature =3D -1; /* Default behaviour is just to war=
n */
=20
 static int acpi_hibernation_begin(pm_message_t stage)
 {
@@ -1004,7 +999,7 @@ static void acpi_sleep_hibernate_setup(void)
 	hibernation_set_ops(old_suspend_ordering ?
 			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
 	sleep_states[ACPI_STATE_S4] =3D 1;
-	if (!sigcheck)
+	if (!acpi_check_s4_hw_signature)
 		return;
=20
 	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
@@ -1016,7 +1011,7 @@ static void acpi_sleep_hibernate_setup(void)
 		 */
 		s4_hardware_signature =3D facs->hardware_signature;
=20
-		if (sigcheck > 0) {
+		if (acpi_check_s4_hw_signature > 0) {
 			/*
 			 * If we're actually obeying the ACPI specification
 			 * then the signature is written out as part of the
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..766dbcb82df1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -526,7 +526,7 @@ acpi_status acpi_release_memory(acpi_handle handle, str=
uct resource *res,
 int acpi_resources_are_enforced(void);
=20
 #ifdef CONFIG_HIBERNATION
-void __init acpi_check_s4_hw_signature(int check);
+extern int acpi_check_s4_hw_signature;
 #endif
=20
 #ifdef CONFIG_PM_SLEEP
--=20
2.33.1


--=-CmcjR5l3dQwM1q5C/6/2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjIwMzExMTkyMDE3WjAvBgkqhkiG9w0BCQQxIgQgD6vX6kgN
2NoHemPRgJrYHidmQ51pij4ZRLhj1AwXhVMwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgABsLkYVEuyqOhhBE5vnxT0B6RpFDADqi3I
ShXXsHA9aaA0pnxh8QfB9QOBIynFnu9vsjyYfkJDFjLVpPRNzkVKI1Xb/BX5TFVrZtsVwGlb0K1I
vkPQys+8oVhwNHcsc0Ud4cQj+Jpe2HiSFyecppam4/oUIQn7pg7/pJ3y5VVCtGEGuikBVadPA3ee
jB81L0jWXW7iEa5etwS7gxqxt2DBGZ+9ECf6f/FgZfq1F7qB3DrrReFOLQIk8+qifaoBVIxLxdcH
vS6PpugiqCU4ST5ESZ+yF6R5HkVHe8n7l/+UCPr3zc9D7nNXe2gYtwif9ickNrHXnZ8HWa7BZ8mk
iRJp7eUcLdBjOZgpnHibiq7eii59edvaJJDgqjNV9GFYVYjMoX2rjoinOLgtuPsKrVrOdRaG9xYV
wY9XNOTMOMSuCd2TeGwCqgW8ah8FbGoTbxIwYv8r4FvUja9ZgB2NMiGSnm4YFlgN5LYyDx4ERNhG
O2c1uaHmSvlpxoI8i6pTJEFykwVR+2EGQprKmoNI23PSJNILKJgpylR5yTCnEEEUJM+Fo/eJDfvt
C6w0NuitF2H6Q9ppZGS9wz1iBvCYM1VahW5EDvC4pALckVuAXYXZYLkV1zDQ4196SWmg5GjbUJ/f
mZrtrAUBqzcS3iiMM8TTDNL6FDHiMi2QqmTuLEHxrQAAAAAAAA==


--=-CmcjR5l3dQwM1q5C/6/2--

