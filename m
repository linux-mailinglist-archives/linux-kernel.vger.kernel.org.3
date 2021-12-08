Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1146D80A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhLHQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhLHQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:27:24 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91898C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:23:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id j21so2664629ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpeBsHFB6eYlB3WCacPzAIVN5v2f8OXbEdK+xuRejBI=;
        b=n9+Ehv25B9izYS6DvOsCoidZsiRlWn+xp5i8odEKYpXsLoUhi56Bt3jJKaK8TgTnjy
         TraMRM8R/H3Jrb5g/o3vz4KiOmRWnOedTG+VTnIj2hyAd+2fGpok1D+4X5ndgXABpqca
         TP1pMYEyy93tVTt2oDLQc7cRsRcpl9LHqLDzxvWsqhREH+greNdSvRiDfF/MjmFaVxou
         jL8h0/fcLI7etSRF/Vz02/GM0t0U9CiFo9Pa6lbm1COx6qqm2Yp7oyUprAzYUZK26lhF
         uOYqnxjxfwJwGK6TczptXpt5D70QwM1a3hn2uRRXpJfPqqLrqm8u0070v6Ft2q1iln0q
         RkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpeBsHFB6eYlB3WCacPzAIVN5v2f8OXbEdK+xuRejBI=;
        b=PwS5eVE78FDlp/TpBF+FdYKnPMvT9phLDCvvVynvk+iTNFoxtScDT82t83YjDZi9WP
         FV0uTY9bmoOZ0Hhu9xOQ/ot89oP54WsClTjIuH/5YIfnIktaYz9ejNXrWwNXmHhMsADF
         Xh04iR/6KSyvcXwpjG0mxBPFTOZQU4jEoIRUW8Axy0x6TxXvF1EeioaML3ux9VbDt1FY
         lqer6PkGdJtQN34w6xpcmqD2i5WWQsZNNHeeeCh9PNLrjmpD09K1D1oAptzpg1RSHetX
         ecf2zCBraBXdwXo9MGlrwTZt2C0UZ3HysD0ZtbTMvu2Hbou2fjo+CImc75fck/BZTy11
         rUNg==
X-Gm-Message-State: AOAM532RPR9oJrvjJfd3ZF0Tm34zGSa4Pwm7HTJpcNLlQ+ZtW8GpRiFT
        NMpzd9a4u0kVJ+0xUCfyLxXVV5cIERc3I0ZCWXr/TiHKXFk=
X-Google-Smtp-Source: ABdhPJxVQkF+aF2MbNgKkiukN5DRV+T8wLOjkOLna7Vo5jp94IsNAeAv7TD2/GW4L2t4ojfwAftaEKK5/PhhTDH+w9o=
X-Received: by 2002:a05:6e02:1a2c:: with SMTP id g12mr9021619ile.22.1638980631731;
 Wed, 08 Dec 2021 08:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com> <20211208152300.2478542-4-qperret@google.com>
In-Reply-To: <20211208152300.2478542-4-qperret@google.com>
From:   Andrew Walbran <qwandor@google.com>
Date:   Wed, 8 Dec 2021 16:23:37 +0000
Message-ID: <CA+_y_2GOg8TXgULBYCLfb3P1YrKX1U7H3nf-C6cMJj-B5j6bpA@mail.gmail.com>
Subject: Re: [PATCH 3/6] KVM: arm64: Make the hyp memory pool static
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000060146105d2a4eaf3"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000060146105d2a4eaf3
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Walbran <qwandor@google.com>

On Wed, 8 Dec 2021 at 15:23, 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> The hyp memory pool struct is sized to fit exactly the needs of the
> hypervisor stage-1 page-table allocator, so it is important it is not
> used for anything else. As it is currently used only from setup.c,
> reduce its visibility by marking it static.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h | 1 -
>  arch/arm64/kvm/hyp/nvhe/setup.c      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index ef6a58a04235..3f60d6cc5368 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -12,7 +12,6 @@
>
>  extern struct kvm_pgtable pkvm_pgtable;
>  extern hyp_spinlock_t pkvm_pgd_lock;
> -extern struct hyp_pool hpool;
>  extern u64 __io_map_base;
>
>  int hyp_create_idmap(u32 hyp_va_bits);
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index 51e68a040d8a..e31149965204 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -18,7 +18,6 @@
>  #include <nvhe/mm.h>
>  #include <nvhe/trap_handler.h>
>
> -struct hyp_pool hpool;
>  unsigned long hyp_nr_cpus;
>
>  #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
> @@ -28,6 +27,7 @@ static void *vmemmap_base;
>  static void *hyp_pgt_base;
>  static void *host_s2_pgt_base;
>  static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
> +static struct hyp_pool hpool;
>
>  static int divide_memory_pool(void *virt, unsigned long size)
>  {
> --
> 2.34.1.400.ga245620fadb-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

--00000000000060146105d2a4eaf3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmgYJKoZIhvcNAQcCoIIPizCCD4cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz0MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
qd3u9nMPvaXsVbwMPzBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMIGaBggrBgEFBQcB
AQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vY2EvZ3NhdGxh
c3Izc21pbWVjYTIwMjAwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20v
Y2FjZXJ0L2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNydDAfBgNVHSMEGDAWgBR8zApo16LrHixyG9HN
XZVvjfvyYzBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dz
YXRsYXNyM3NtaW1lY2EyMDIwLmNybDANBgkqhkiG9w0BAQsFAAOCAQEAajBIqjTLb65loo5f300X
u7oe5++cidgOWlobHh9CIwYzejSGdBw2VEAGnTqKEqTftoGHiEobnRbz0YibhaeI6myx1ANKPUmG
ISl47qlazJAZoqPc+iofgNOSv10xcLSSPjbxqLBlB4iV7vkgwha+26s9IXRRQzxnKHFsrCuxNkPd
Yea60MlnfbCnQkhesEYvI9zZyIezhJnKAvKSBcUGt/V3q4EH8RhIokrnclLU4qggjwkbozVwiREO
Z7RKIVS3OOrJoGNqZCyc/Ofg33pvfy8UgConrY7dlccLZOH9GJ/krmwAp9Sr0SZhLxgCfSXbReaf
FT6N00mzsDKwf3N9GjGCAmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMAIQ
Ae+7eLPFqETXFnZkWuTFajANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgNOgTbCDh
Q8KpUyCka2ICLtCumTX+xggTQSCR2icN7DQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjExMjA4MTYyMzUyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALH5BZwvVPxIxZYJSAmYgO7TZ6iP
Mj1EAx9V9Vv2dztzUMxpUeWMtUo8mB1slSS/qEVTwwCNsj0TdSVd78sipAqftiT72+PldQDkA+vQ
+kHnqmvauDK3oS9aqocOLArzGhKZ20ADWTWjHm6eNrXlcZslEg0KYvJwaA80lZXzSOgvHKBHWzK3
OxnsQe7MjYA81E7jcOyJ0vwlvQOn91xpkAFrm9xHrrlyZKAhUE1QB/yDGNOFwzomQoeF+Kqa9x4V
kDPnd9Q05LVPhXd3sNsWk4o7Lfjun4yZgxCcDTmLdMcg29VU6HiVQ5rAZ1eUx2bCyVDyP4eEGYTN
Vujk2vA1Hm4=
--00000000000060146105d2a4eaf3--
