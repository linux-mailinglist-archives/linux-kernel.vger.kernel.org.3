Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2950A9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392349AbiDUU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392334AbiDUU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:29:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3AC49C90
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:26:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bf11so7133398ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=bOCI3XFea2q/xxFJgKExCkX7ISgseBMqDiJ+lR8tNBc=;
        b=B1Ms+gHdTdEV79mFnP5ybY6oNIXTUchZGfSeBG1qm3r2CQMpPRaeGr88MKrf+f4eh2
         ctdEY3cNoHH+v6cmuM5ZXI0K6rERayhyr/QqYyiFADYHF1yFGNX2ft8YBSbJYsuiCHC6
         3GILIbaVhFAO7QXzEjpPCqjDWWvKN9NOnKCvpQod5K/Vy1KoIy9+peGfx2ucnaGpuw3n
         C/AfVUeSJEc33+8xE0ZN21US/UYc3d2pviPLtNFtv8pVI4sM6hJ4+HDEo1zdknJzz4KA
         m25Tl8tFQ+SY/vEreqKDggj7twoIoAPMMVV19Z3jdbPz9h7LaR4181q5eJ2tm7R+rVWM
         qp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=bOCI3XFea2q/xxFJgKExCkX7ISgseBMqDiJ+lR8tNBc=;
        b=p0oMHNpggdkmSCsP5Wq3c+/Jslh8DYyIWmNSvtcfKidxc8uN9GVhJy+P7CAtq3L9TP
         tzb32ahpVrCuoyqTR+o7GN8u8Ddfc94poY/OxfjDijusboFTHs3ck3+jvHWpEzZ4pBds
         PalCTaLswkH3HQa7VSaZZhxH+qGAk3MKMpd0xHPPjy+7+PiMZEc/umA4j1DsYROkjUw1
         EU5Kxk92HUN0LTse8p1K8K44UM80bETOktLbsvQaf6tl/NPGc5agnstM1HHW0VXtrb6y
         R5gO/r17fc/aZ6yJSE5o6lNYN+Z6GLQpZENHiV4imIvH84KWK+SzV+jpP/naJHsqqxOR
         LLGA==
X-Gm-Message-State: AOAM530euP6evAEAnVKaaBqC3haEvGVq4N7r3yL9TKwV8QeGpb5YP2Ew
        9y7Rm06g/gLHSJaBJGrrZo0=
X-Google-Smtp-Source: ABdhPJzyGhv1dqQJIx/WE8K+sydflcemDtAPR4C2BV+AVCJkoFz2RuZ/zunT/JwZe6tjlANYK2MHxA==
X-Received: by 2002:a2e:a7ce:0:b0:24e:e213:ee14 with SMTP id x14-20020a2ea7ce000000b0024ee213ee14mr765087ljp.491.1650572767673;
        Thu, 21 Apr 2022 13:26:07 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e9256000000b0024dbc6edecdsm1282919ljg.125.2022.04.21.13.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 13:26:07 -0700 (PDT)
Message-ID: <83061bda-5a91-6123-a006-aaeb5458d5d7@gmail.com>
Date:   Thu, 21 Apr 2022 23:26:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] general protection fault in ntfs_update_mftmirr
Content-Language: en-US
To:     syzbot <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
References: <00000000000022487405dd25bd0d@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000022487405dd25bd0d@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WYJmKsAde7MM8USQat5VktCr"
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WYJmKsAde7MM8USQat5VktCr
Content-Type: multipart/mixed; boundary="------------dsXtaJ5yduLP6icDnkrHiATx";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: syzbot <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>,
 almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
 ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Message-ID: <83061bda-5a91-6123-a006-aaeb5458d5d7@gmail.com>
Subject: Re: [syzbot] general protection fault in ntfs_update_mftmirr
References: <00000000000022487405dd25bd0d@google.com>
In-Reply-To: <00000000000022487405dd25bd0d@google.com>

--------------dsXtaJ5yduLP6icDnkrHiATx
Content-Type: multipart/mixed; boundary="------------ssQyUC9tA0KRqpE4gITNPWZ9"

--------------ssQyUC9tA0KRqpE4gITNPWZ9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8yMS8yMiAxMToxNywgc3l6Ym90IHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IHN5emJv
dCBmb3VuZCB0aGUgZm9sbG93aW5nIGlzc3VlIG9uOg0KPiANCj4gSEVBRCBjb21taXQ6ICAg
IGIyNTM0MzU3NDZkOSBNZXJnZSB0YWcgJ3h0ZW5zYS0yMDIyMDQxNicgb2YgaHR0cHM6Ly9n
aXRodWIuLg0KPiBnaXQgdHJlZTogICAgICAgdXBzdHJlYW0NCj4gY29uc29sZSBvdXRwdXQ6
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTExNTg4YmEyZjAw
MDAwDQo+IGtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94
Ly5jb25maWc/eD00Y2RjOTYxOWY0NTYzM2RmDQo+IGRhc2hib2FyZCBsaW5rOiBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9Yzk1MTczNzYyMTI3YWQ3NmE4MjQN
Cj4gY29tcGlsZXI6ICAgICAgIERlYmlhbiBjbGFuZyB2ZXJzaW9uIDEzLjAuMS0rKzIwMjIw
MTI2MDkyMDMzKzc1ZTMzZjcxYzJkYS0xfmV4cDF+MjAyMjAxMjYyMTIxMTIuNjMsIEdOVSBs
ZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIuMzUuMg0KPiBzeXogcmVwcm86ICAgICAg
aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5zeXo/eD0xNzViMTNjMGYw
MDAwMA0KPiBDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
eC9yZXByby5jP3g9MTUwMmY4NTRmMDAwMDANCj4gDQo+IElNUE9SVEFOVDogaWYgeW91IGZp
eCB0aGUgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1p
dDoNCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCtjOTUxNzM3NjIxMjdhZDc2YTgyNEBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tDQo+IA0KDQpJZiBudGZzX2ZpbGxfc3VwZXIgd2Fzbid0IGNh
bGxlZCB0aGVuIHNiaS0+c2IgaXMgTlVMTC4NCg0KI3N5eiB0ZXN0Og0KZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBt
YXN0ZXINCg0KDQoNCg0KDQpXaXRoIHJlZ2FyZHMsDQpQYXZlbCBTa3JpcGtpbg0K
--------------ssQyUC9tA0KRqpE4gITNPWZ9
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL250ZnMzL2ZzbnRmcy5jIGIvZnMvbnRmczMvZnNudGZzLmMKaW5k
ZXggM2RlNTcwMGE5YjgzLi44OTExMjVjYTY4NDggMTAwNjQ0Ci0tLSBhL2ZzL250ZnMzL2Zz
bnRmcy5jCisrKyBiL2ZzL250ZnMzL2ZzbnRmcy5jCkBAIC04MzEsMTAgKzgzMSwxNSBAQCBp
bnQgbnRmc191cGRhdGVfbWZ0bWlycihzdHJ1Y3QgbnRmc19zYl9pbmZvICpzYmksIGludCB3
YWl0KQogewogCWludCBlcnI7CiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IHNiaS0+c2I7
Ci0JdTMyIGJsb2Nrc2l6ZSA9IHNiLT5zX2Jsb2Nrc2l6ZTsKKwl1MzIgYmxvY2tzaXplOwog
CXNlY3Rvcl90IGJsb2NrMSwgYmxvY2syOwogCXUzMiBieXRlczsKIAorCWlmICghc2IpCisJ
CXJldHVybiAtRUlOVkFMOworCisJYmxvY2tzaXplID0gc2ItPnNfYmxvY2tzaXplOworCiAJ
aWYgKCEoc2JpLT5mbGFncyAmIE5URlNfRkxBR1NfTUZUTUlSUikpCiAJCXJldHVybiAwOwog
Cg==

--------------ssQyUC9tA0KRqpE4gITNPWZ9--

--------------dsXtaJ5yduLP6icDnkrHiATx--

--------------WYJmKsAde7MM8USQat5VktCr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJhvd0FAwAAAAAACgkQbk1w61LbBA3s
7Q//fygiink/M03wffJG1qTJ2957UF3sTU0c5xlH5HHm9H/C0qxLX3HFj77JNCZE0GSTVpib0S08
TZZH/1MlxG+oZUvB1HhPAaZ1f/6IpqkY4VEDgAgSlo+ALcQSIce9sGgHaFW3psiMvMJkWz7EP9kd
ZODJK7vvgm26VyEFnMJ9VYeVopCO3rNjWsQ/JwlmlTU9zMABupGaR8oPWn0QDicO6fMNwqh1Uh0u
Bgiv5ST9C7bh/qe9xZK9Ku7siEh3qt1yj2NzGAp5viKs5tQKPkO2FAj9LFww+FhrAqD7wbZJtIpu
Vm/0P9b1uZAQEXZ3m+Ve2zq396z+kvZwLu/SE6aTlxKJaT0uHS5iKOJOdh3byIOah19fXpP5llQs
a6BOWJUz9+JtQHKwNPbNUSlFauzS5Gv/sfs75TDPthkTdzllZrVSokpMruhPMPGu/9a4+9WmbPLa
c4RQFBSsx9SYzD0Plxl/8gO8LhBeOTdmehjGM7kIjMQcrMKVjMOJJg9xG9T6NLrIytwellpmuEAt
uCeHeOEeXkaHgIxl8f7L2fFzi7Lc8EjQp/nyQ43m2vyQj8nEjy2ZR6qGJvrOip+MFUB+1ghUIvbr
rr+94RJsmXu1eG7Fd5NDOIPYN90cy8aM+khb0Y3CeEWRWW5qnd6CJSMSxDRKrLxyotOBv1ZmchZ9
7jc=
=u1KX
-----END PGP SIGNATURE-----

--------------WYJmKsAde7MM8USQat5VktCr--
