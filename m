Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CB4A8BD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353557AbiBCSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBCSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:45:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:45:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so3853733pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=FB8yRHJUzpD0MFH4L8YwMvSolPZvqxV9MdpwVySSgWY=;
        b=cOC1WLxdp2XtrvoveFdOdGDupYHDwL+X/IG/SSIZltZRXBTOKff/GGD9QGvG+1I0d5
         dLZS1dMpu5j6+TYD/Fk3BckhFW9bmUMPAnvt7TgqXalAMnr3YEbgqIdFx24/TA2u6XZa
         Tc9WpuZnVNchOmyr2LhDLZNX5OWPuJVce7ZJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=FB8yRHJUzpD0MFH4L8YwMvSolPZvqxV9MdpwVySSgWY=;
        b=cY/4EeCvmOoV5Ta0JgEs2+haJ0ME7AJ52I/nCNv+AW+sDUpLrI2ta/GbuG9QqFpx0Z
         K7OM4KeuRbt6Vo/Q3M0VuHdqyxTMYoJpRJU8TsL3JD6g1IZyWGw7iog12PN28GOXQ16W
         3HWFVhE+JIzygClI08TwU7V4t3xzzHl8MUpBKky92O+ORFBsfAeqbkVESGTV3tZPW0/J
         AL4tx+P98l1QVfw5FJVsc+qLELUCuQBynFCpH8gFMmPwmEJ4tyrjR7EOleTVcByqdxsZ
         0FGGOlphVsNTGKscd2m5jvn2ZNnFt1E2yPeuP8pVqycaoHkh0fG4qKHzH+3Lp6lb1k1T
         +qPA==
X-Gm-Message-State: AOAM533K1yKf+W/fGRVNr9U3wk+CdvE7zFT8ySdXZB6mOt0pCyn269mM
        ucMf2fMyCRsTufdDoT2JWOfWNw==
X-Google-Smtp-Source: ABdhPJyZPfi/g+maXpNoePn8pJLIDA9j3KMz8SdRUCTa8n82gTdr0ca/yL4+uK098efTzuaMrisa1A==
X-Received: by 2002:a17:902:eccb:: with SMTP id a11mr36997381plh.121.1643913925149;
        Thu, 03 Feb 2022 10:45:25 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id lb7sm11699826pjb.56.2022.02.03.10.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:45:24 -0800 (PST)
Message-ID: <a7545293-431f-c285-e7af-e51d31d41965@broadcom.com>
Date:   Thu, 3 Feb 2022 10:45:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] soc: bcm: brcmstb: Added support for PSCI system
 suspend operations
To:     Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220122035421.4086618-4-f.fainelli@gmail.com>
 <YfvD2KklLEZX7Pht@FVFF77S0Q05N>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <YfvD2KklLEZX7Pht@FVFF77S0Q05N>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009469d105d721894b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009469d105d721894b
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 2/3/2022 4:09 AM, Mark Rutland wrote:
> Hi,
> 
> On Fri, Jan 21, 2022 at 07:54:20PM -0800, Florian Fainelli wrote:
>> Add support for the Broadcom STB system suspend operations which
>> leverage the standard PSCI functions and uses the
>> psci_cpu_suspend_enter() operation to power off the system with or
>> without retention ("echo standby > /sys/power/state").
> 
> What exactly does this enable that can't be achieved with the existing PSCI
> driver as-is?
> 
> When you say "retention", what specifically do you mean? Retention of CPU
> state? DRAM contents?
> 
> We already have SYSTEM_SUSPEND for states where DRAM content is retained but
> CPU (and some system state) is lost, and IIUC we can do suspend-to-idle with
> CPU_SUSPEND states.
> 
> interface necessary?
> 
>> The system reset path also supports a special "powercycle" mode which
>> signals to the ARM Trusted Firmware that an external PMIC chip must
>> force the SoC into a power cycle.
> 
> How does that compare to the regular SYSTEM_RESET call?
> 
> The PSCI spec says of SYSTEM_RESET:
> 
> | This function provides a method for performing a system cold reset. To the
> | caller, the behavior is equivalent to a hardware power-cycle sequence.
> 
> ... so I don't follow how this is different, unless this platform's
> SYSTEM_RESET implementation is *not* actually performing a system cold reset?
> 
> If that *doesn't* perform a cold rest, it seems like a bug?

I think you answered that by looking at the code down below and the use 
case was to define a vendor specific method of resetting the chip. This 
is something that we could sort of always override one way or the other 
by registering our own power off notifier callback with a higher 
priority to make it take precedence, assuming that the platform is 
indeed brcmstb so we don't override other people's systems, too.

> 
>> As much as possible extensions were built using the SIP namespace rather
>> than the standard PSCI namespace, however compatibility with the
>> standard PSCI implementation is retained when CONFIG_BRCMSTB_PM is not
>> selected.
> 
> I really don't like this, because it seems to be creating a parallel
> infrastructure for doing things that can *already* be done with standard PSCI
> driver. The actual PSCI bits just seem to be playing about with the power_state
> value, which we should be able to do in the regular PSCI driver, and the
> SIP-specific functions seem to have nothing to do with PSCI.

The implementation is standard in the sense that no PSCI function call 
had to be modified in a non-standard way for system wide suspend/resume 
operations to work, but yet the mix of SiP and PSCI is not properly used 
to differentiate the platform as you reported.

> 
> At the least there needs to be a much better explanation of why this is
> necessary, but overall I'd very much like to have *any* vendor specific code
> for suspend states, and if there are limitations in the standard PSCI driver we
> go and address those. Otherwise we're going to gain a plethora of
> vendor-specific suspend implementations, which is exactly what PSCI was
> intended to avoid in the first place.

Entirely fair.

> 
> I have some specific comments below, but even with those addressed, I don't
> think this is the right approach, and as things stand, NAK to this.

That is fair, I think I have a clearer view of how to support some of 
our uses cases by extending the existing PSCI in ways that is hopefully 
acceptable.

[snip]

>> +static int brcmstb_psci_integ_region_reset_all(void)
>> +{
>> +	return invoke_psci_fn(SIP_FUNC_INTEG_REGION_RESET_ALL, 0, 0, 0);
>> +}
> 
> What's all this? Below I see the phrase "integrity checking regions", but only
> the brcmstb_psci_integ_region_reset_all() function is used, and it's not clear
> what this is supposed to be for.

Will remove that. We have a set of function calls here that allow us to 
define which specific areas of DRAM are to be hash checked during 
suspend, and then hash checked again during resume. This is used both as 
a debugging tool to spot faulty board designs where DRAM power is not 
retained as it should as well as a security counter measure.

> 
>> +static int brcmstb_psci_sys_reset(struct notifier_block *nb,
>> +				  unsigned long action, void *data)
>> +{
>> +	const char *cmd = data;
>> +	/*
>> +	 * reset_type[31] = 0 (architectural)
>> +	 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
>> +	 * cookie = 0 (ignored by the implementation)
>> +	 */
>> +	uint32_t reboot_type = 0;
>> +
>> +	if ((action == REBOOT_COLD || action == REBOOT_WARM ||
>> +	    action == REBOOT_SOFT) &&
>> +	    brcmstb_psci_system_reset2_supported) {
>> +		if (cmd && !strcmp(cmd, "powercycle"))
>> +			reboot_type = BIT(31) | 1;
>> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), reboot_type, 0, 0);
>> +	} else {
>> +		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
> 
> If there are a bunch of specific SYSTEM_RESET2 values we want to expose, I'd
> rather we described those generically in the DT, and somehow handle that in the
> generic driver.

OK, it that seems appropriate, I will propose something that extends the 
DT binding and standard PSCI implementation.

[snip]

>> +
>> +static struct notifier_block brcmstb_psci_nb = {
>> +	.notifier_call = brcmstb_psci_panic_notify,
>> +};
> 
> This appears to have nothing to do with idle/suspend states (and so might be OK
> on its own if you need it, but it should be in a separate patch with some
> justification).

Correct this is orthogonal and this is just a signal to the firmware 
that kernel has panicked.

[snip]

> 
> Immediately after this switch, we know we there is *a* SMCCCv1.1+
> implementation, but we have no idea *which* implementation that is. It could be
> Broadcom's brcmstb implementation, it could be KVM's implementation, or anyone
> else's...
> 
>> +
>> +	/* Check the revision of monitor */
>> +	if (invoke_psci_fn == __invoke_psci_fn_hvc)
>> +		arm_smccc_hvc(SIP_SVC_REVISION,
>> +			      0, 0, 0, 0, 0, 0, 0, &res);
>> +	else
>> +		arm_smccc_smc(SIP_SVC_REVISION,
>> +			      0, 0, 0, 0, 0, 0, 0, &res);
> 
> This tells us the SIP interface's revision (if implemented), but not that the
> SIP is Broadcom, and we still don't know that this is the brcmstb
> implementation specifically.

Good point.

[snip]

> 
>> +	pr_info("Using PSCI based system PM (full featured)\n");
> 
> This should be explicit with something like "Overriding stnadard PSCI
> functionaliy with brcmstb-specific code".
> 
> As it stands this is at best meaningless, and at worst misleading and
> disparaging of standard PSCI.

This is meaningless and a left over from our downstream tree where it is 
used to determine the generational level of the implementation, I will 
definitively remove it.

[snip]

>> +#define SIP_SVC_REVISION		\
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
>> +			   IS_ENABLED(CONFIG_64BIT), \
>> +			   ARM_SMCCC_OWNER_SIP, \
>> +			   0xFF02)
> 
> Looking at the SMCCC spec, isn't the "general service query" REVISION call
> 0xFF03? 0xFF02 is reserved.

Sure is, whoever wrote that probably did not know it at the time (not me!).
-- 
Florian

--0000000000009469d105d721894b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDHG7gDNoanCGtqaNhjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNjU3MTBaFw0yMjA5MDUwNzA3MjNaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAu10WSl35INx8Ma97NH54zM3XKzx8Lo/KErWP5HPBtIxzYjBL20TDg9Jmnnbs
rZjwEVNKY30HiBRJcooDpalBATQpdw3kdYEgojrrXjVz4a+YaWhLbV0OwQ54QAkwKsdYTnuUX0B4
YLYGuUBDXYkcFWZv5BiAF4L97ClbTnUUCry8bhV9SP8b/tbivOhWUSjHLsQ9gEjuLhVId3Xgs9dA
TtoyOTJVs6HDth0+/13gxSrB3BwSY4wtw7EPHshswD1fzSV1fZf7QUQedadjH8BMBaKKseIieb6M
bhjsippX2btWEJOuUFS5RkK5HFFkzcGtIQd+gltZHQHohAcopF+cSwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIDZLMN77
IWw6rnhSvGm2V4nv3AowDQYJKoZIhvcNAQELBQADggEBADVdzyh3BQZiABHSdL7LQPNr6/6OQwg7
65j9Ggyr2Rdl2RnQIifKtGGodVlJ8e9XCYt5rCNU8PriYstIk4jlMJp6SziSN0CLE+A+FujmTqZJ
X8vEct7sdLXqdlBvR23TLvnkxbS3RwED7FDDTxpIv5j87o78e+wrZOPvDskdrYXVWGUu23xmd2IS
kYMLAXNeGrVe6HovEKCJPw07+B35iJvwdpZBXiti5hFa3q1L0+K5nGMpceIrj4dOOkSNB2ipHR6H
Q5HbB0UbWMkRv1PYpxf5eMjyDqxNigsE2JIFa1nk8ckA8hoTKbypCoALjcSuNqdZZyOnMBSKguHJ
Zz4bBBwxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxx
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPjNw8DbHtdezLAc
JPOnNovomGmBoaDwK39oz8XlZw8OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIyMDIwMzE4NDUyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRXNmuAZcgHI8Q0IKhPImRvSf3Sa4AZ8LS
1nHtdhzaHzdy6Hopn1QtpzJ29JUYwk3rxTW7ApaEM6radMH+Ah1F3L4ZTx0aXkvUSt04IpbGvHzJ
EOVjukUxFZ4uv4X/pbuG/xUG1xb1FfKmuk6/ZJ8Rex0Ker1yCoBjfXro24QZkfRU7WD2p1gglVQj
OI9RPHPpYZuLQtMjUYQE08aEOWV+E2UI7q5zAVcnTjHzYaQ9W926SPr6GPtQQyE7Eep6fJEqKoJ2
Sqb4IL6rgRxiUQO+EQBGmHX4HMnwfBK4DgsoH07ubVGUGu/SSZprTevQc0xbXdmwF9h+YNh33JQl
c0IT
--0000000000009469d105d721894b--
