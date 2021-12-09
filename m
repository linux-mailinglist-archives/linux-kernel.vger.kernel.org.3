Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F146E4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhLII7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhLII72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:59:28 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4DC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:55:55 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id n12so10714887lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=pMGZyFrm7H/qama6frDDe69lJwdy0pA/LI/N/YiYQ8s=;
        b=ZkRwmO2PzMRtt1Pf8QjQNJM7n7bSbI8Mk8xEjnzIHJzK88EtPh1VMmEaKqL1Mk2wQ7
         vFd2jimmlemXFp35RQICTWK7TjU3HJOP8GkBDOlCelDvBZ67j/SgTyewpbivbTDo+IXb
         3Ccub5r4AFyRuB3aiQP/TBEAMNpFlygDFvd1ujzvq1MaQ8D6DbRPqHx9n0P2hkw2bBW2
         hvmaBg3bMaGohTuF6+rQgg5RJEKC4sAw29kZKEJzNKHj1EyB3JHqHgYPu3s6gzR78nNe
         9/SQSZx1+jiOEnZYvwsyYW8fzSEBiiXMcfKJ6lgTF7x7UQ5n/teEnjTDOUNo6Rr9UtR4
         ycNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=pMGZyFrm7H/qama6frDDe69lJwdy0pA/LI/N/YiYQ8s=;
        b=MjheZ/UHc8Z/E0iUl/1MV/HxQZVgFQnwjB30TaiRBdNLJ/CKYRqaMqdSQcA5M1b87T
         BFrYzhK96dTZRePHyAqsDzEZDRPu81CCj4MnSvhaSnQb9WzIHHfMu8GV40mDbZ9i6yCU
         2Q0is/x6Rg9qd4fdelLogcd3jUO93iSdXyADvbZXghGLGtnWYWGtvKJzyQU+UUAcBx0P
         M/4zPA3FJxlwu4fK25W1h1kkP2RIU6cXFGcdtN9xYmIB6J9rBCMq9cpzvzFoW2ZAeH/y
         d+XiT3oyo84LgAS3g01B9Dl7svDIxNBoN+pg085vx2+kct15vRwgl+lAwGbP4fXIFmUT
         siMQ==
X-Gm-Message-State: AOAM5328xuwzl50wS2TUr32cZlyHz/MOmmuhas9PrXc/wJI/wTJXFomC
        Z3UQVhI9gMGwoVYPIQL3lqbCTz3gQlsx553VpU4=
X-Google-Smtp-Source: ABdhPJwkakLeuqR9zOyGhouHK0nBOMAa0eUvxK09J0+SrnnJK/j+WpL9ltB7eozi4QLiDgh7We/92BUsK7CEuPiePlw=
X-Received: by 2002:ac2:4d5b:: with SMTP id 27mr4781047lfp.596.1639040153268;
 Thu, 09 Dec 2021 00:55:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:990c:0:0:0:0:0 with HTTP; Thu, 9 Dec 2021 00:55:52 -0800 (PST)
Reply-To: martindevatta@yandex.com
In-Reply-To: <CAM1crw6342fkzZVVPx8rQUt2p_i6AaaRJr58MaZF8Lj3YoY3Ew@mail.gmail.com>
References: <CAM1crw5f5fjZiMNLN-5n4SC9b08wyCsR2ueLFjfXjk_kx9MX0g@mail.gmail.com>
 <CAM1crw54_nwXnOgP-pLzyarLRMYCpcTrtZ0vnmJ=+_BGs+yL9g@mail.gmail.com>
 <CAM1crw58uPNFu0SJBzBgHXiFqubk5xrpdEtZjubfu17VR9XKag@mail.gmail.com>
 <CAM1crw5qhWTtvMVx6A6dERWoA3ctVNQux7NLm4hSa+mdrvZFMA@mail.gmail.com>
 <CAM1crw7mguckhNXvPP2iY0qWoUDwRzz8R4_rRj5aQ3dDNUmoLg@mail.gmail.com>
 <CAM1crw7bwjDT9XweSPYK8e8e+YZzAkvzksaedTPf-oLV0tmX1Q@mail.gmail.com>
 <CAM1crw6+9kYyvRKAydc7PGoHvFSEMgghaT1wXbfE6TceeWc51Q@mail.gmail.com>
 <CAM1crw7uAc=9hA=sMBt8taWdmh2Db5S=J5o64VpkUs-ndpMn-A@mail.gmail.com>
 <CAM1crw7qZjf-fx4y8kyrz5pUOS-Eq0fm7CAoM92C0SVfYGxUjg@mail.gmail.com>
 <CAM1crw6PQ0yi2a7RD_H4m5NDQ36159AKx9hkvf1U281zNFavww@mail.gmail.com>
 <CAM1crw6WDM+ghJrAdLM226o2GmrOdqhOjV-jOnR4HWf8VeZp=g@mail.gmail.com>
 <CAM1crw7i2aNkpy0pMs0kXXfVqufSGd7BFCCr1zUCoWcdd7Chjw@mail.gmail.com>
 <CAM1crw5rLxSqi3_H4JRxZvHHXOWamA3m7e3wrosZ-=-exTic4g@mail.gmail.com>
 <CAM1crw7uyAR+8E6kVsZpQtxhgpKkjRjiSwjJLmeOHjqNOL7Umw@mail.gmail.com>
 <CAM1crw678KS8umTJA2htWrPFLPZkiUOsw8TKVpX74zm1bMhShQ@mail.gmail.com>
 <CAM1crw7ZbN=yiFY2k0LkvRKH+Lp8tuMH1DvpQOthEWuK7Gq1XA@mail.gmail.com>
 <CAM1crw7USq99SiD4mMejzN6M1EXR-UQVUV=P13zKasvheEasYQ@mail.gmail.com>
 <CAM1crw6DhictVXLbYwa6fQ6p9B-E12Ewzmp-yjpzWTE-0Tigzw@mail.gmail.com>
 <CAM1crw5a3ov6dzR4MRgJ8jP81nudzhb4amgxirbhihfNQUf=PQ@mail.gmail.com>
 <CAM1crw6D65otdnYEaMTr9P1tK4BzdLy63sO3WpG7cJa9Uvn1Tg@mail.gmail.com>
 <CAM1crw5kR-5Rr=TeOZv-RJ8-Mbm8Lb5Zp1tyHWQczmOX_Evveg@mail.gmail.com>
 <CAM1crw4+m4Tt0=i6p46ZN8ZT==f9hwSMzdDvK1-h4cR++ZoKoQ@mail.gmail.com>
 <CAM1crw7PaF0-SSTEf3B1JncpZg+g5b4M43HgtFbSqcnvQAGwLQ@mail.gmail.com>
 <CAM1crw6qW2Bz-1cTDLE55aocaq4ahwrLpvNQmQsNbd5nXweBbQ@mail.gmail.com>
 <CAM1crw49Xbss=KWbcuXzDtNTmB2amfpxnUkHWef0Z__NdDKaLA@mail.gmail.com>
 <CAM1crw6Mxq3yKxoEAKk7-ojHe_NxSVjkR0dXqF1dowNSJzUDZQ@mail.gmail.com>
 <CAM1crw7bx2p3J+0E+bavADq7wJx+xZk43TJh-NEsnREzf+DVZg@mail.gmail.com>
 <CAM1crw42adx2QPScJa+zFQFTZHQUhSJ0xg1h46nVn7i9zRNZXQ@mail.gmail.com>
 <CAM1crw6D10FEdFm-Ky1xJhNVKQuoNBJT==XBXn6ZMkYheZ_2Ug@mail.gmail.com>
 <CAM1crw5h-np2-F1kcjczYmB4zs6+0Q1bX=4cQGjAm8Q8NwJ8Mg@mail.gmail.com>
 <CAM1crw7=pNT+d0g_soA+FErB-fEXHjGASnWQ-aU28oRLvpAmDQ@mail.gmail.com>
 <CAM1crw7GkV3kur_WwAxs_uf4PZeCu6jfrmRQj_c5uDSJ1cjVAw@mail.gmail.com>
 <CAM1crw5-BAzac8fQWvYDTmRaxt=1PgMUU=cTwrYgB+xKOLYfwg@mail.gmail.com>
 <CAM1crw6J3NTh4N6565TaF-e_UT3eSP73xeJD7o3LS-J77ULCkw@mail.gmail.com>
 <CAM1crw5HHKEh25ZiC6bMR6f=AKuuMUyjSK2ubMkHhMe7v4_Q1Q@mail.gmail.com>
 <CAM1crw4gPv3__kUmhH+XU2A1s8kaHEQbUh+6+MPcff13b7ecWg@mail.gmail.com>
 <CAM1crw4gU1CAe-rr+OP=1jwnenX9O++tFOJMwsX=mz_cyc_N3g@mail.gmail.com>
 <CAM1crw4Tntq3sexy4KJ4VV9i1xg2Bb2kF=EY6tp0wDvZj3Hpmg@mail.gmail.com>
 <CAM1crw4Ar+3dMKvMDSvAjXq6Farx+LJOy2aJexP-qQZrwVdOHA@mail.gmail.com>
 <CAM1crw4D_ZMjCosfX91HcWAjJ+FCJD=khSEbKA87rLHPn1Zhhw@mail.gmail.com>
 <CAM1crw7LwrztLjWTFspCQcVj+WMGK8523TDcLuAhDynU6CUejQ@mail.gmail.com>
 <CAM1crw5+nReyQ7RY01MN-6ScoPwJXkxdhrtybDDDn5WhNLDqOQ@mail.gmail.com>
 <CAM1crw5YiNdmmsEgfTcUSx2bx7aq9biOu4tcWpB74-p0zbZW9Q@mail.gmail.com>
 <CAM1crw7LYk3X7HZu81r4usVQXd8uOF78bYXKpE5JnQvhafYxVQ@mail.gmail.com>
 <CAM1crw4XcuQbX2zF-i1eQnqDgF0+eT_GxMtCyDEVgBxddvHJCA@mail.gmail.com>
 <CAM1crw40UtiLMwj1X8KVHZjpFo=yg+EcpaF+LBv+nvgTcxn79Q@mail.gmail.com>
 <CAM1crw4WMOyiCq7WaN8jHKh_ptL5YF28t+wo-iGd8ehPdX2wnw@mail.gmail.com>
 <CAM1crw7BJY1nmzP2CA7tksn4czfqaw=ZmyaRYemxAQ=O=k0_QA@mail.gmail.com>
 <CAM1crw7TbJ_vbyvpQECvdxQoKmauoJ2ZCRPCGp4z_VqZyBSZMw@mail.gmail.com>
 <CAM1crw7MXzakhauQ9prw2UyirLmK11rsD6K41nBv9ixbeBBooA@mail.gmail.com>
 <CAM1crw6g9PuN+Jf-UsRt02Y7++nk+ytK2XQPTwRrH8O2Cs99Pw@mail.gmail.com>
 <CAM1crw52tWMOFz9oYXayThWR2qJjFwc5vFs=6+zxp0ddAR3M-A@mail.gmail.com>
 <CAM1crw7tkTfDNdQfiei3U-eZe=eZzjHF_n0O_obdJqkhU7hmnA@mail.gmail.com>
 <CAM1crw75bcy5J--0i_mLCJ_9etjmP9Hj6_gdc_9k-M1MhH_Q=A@mail.gmail.com>
 <CAM1crw4d6ypsPmx8SAruyyK4e0s=1sAtujz4X3d_oKgQ3M=Dhg@mail.gmail.com>
 <CAM1crw52QFa-fcVDhzH_SRnHOO+q6SJaCv2ZkmN=POwOJwe98w@mail.gmail.com>
 <CAM1crw6O--rjfHJ-8Hx_rEgdquA+stpp6B-CwteV2w0KfTXE_A@mail.gmail.com>
 <CAM1crw7_fDPMcPrWWiM-Av09_7vX_HZdRzsr38sH4ysogDra8g@mail.gmail.com>
 <CAM1crw7X5CeE7sB_617vUTrk7S3Z4-op4cyE9R_-VYDpUS95Jg@mail.gmail.com>
 <CAM1crw5X+82Omjnm878EJ0EYbUb1sXrnLSODyPBuLF37HmYk1g@mail.gmail.com>
 <CAM1crw61Q6fhfFPWZ8U1iCkuOPWNtTg7n8QUUsPMRuPchjaihw@mail.gmail.com>
 <CAM1crw64sykdAhfHqp4SwjJ7yS_26sR8YBONOgMneMowEHUpKw@mail.gmail.com>
 <CAM1crw6SdhfXu9FsYKw3seUod0FvoNM2YKabg_rmt5eUhSafvA@mail.gmail.com>
 <CAM1crw4Yy=9Teu-8gh-ShrJpzXtBCouApuX1joupLtrj4Av7QQ@mail.gmail.com>
 <CAM1crw4dUdT5eAGTcQ9K6hPq0S5fZhCp5TJg+0QA0EUw4Z8Q3g@mail.gmail.com>
 <CAM1crw7KVStDGrTpxfx4XdVSmwBmhHNLwNshY0ErZRnm=LSYgA@mail.gmail.com>
 <CAM1crw7RfcOGk5aSeZDPJFdSiyKFm6_sL34yCpwfMrdeMt3P2Q@mail.gmail.com>
 <CAM1crw4TGug6JMWPF4RsiJXwbBStGpB7TsWJe1G-yUVy=PRs0A@mail.gmail.com>
 <CAM1crw5w23h89hATOv=kYVyTYsfhi90aqp8j7__Nia=3fBCtfQ@mail.gmail.com>
 <CAM1crw7AF2NUNuxNuB_dp1okKdLWGv_aKPcWkpOP7idh4cQ+fQ@mail.gmail.com>
 <CAM1crw4D+_PxG-mFVaqH6PiN2HWjZsujw15nY3if8rXb3erVXg@mail.gmail.com>
 <CAM1crw76vdh85vPmvKFjgDiNS9cFd0qzty1OLZb77uqSsauzzg@mail.gmail.com>
 <CAM1crw44BtnedVkeQia9Y3R12zpkqNOF6fCBKcB91WkckYZfHA@mail.gmail.com>
 <CAM1crw5SbPXzmd461K=N7EdNE1WzAa41-z1QBob3GNDxCNQsAg@mail.gmail.com>
 <CAM1crw7FsOyDngFh3=P9eeAFXeOvS7RBgiFdjhfx5_RMXZAJsQ@mail.gmail.com>
 <CAM1crw6ZT-0QpQmsAgJf8oFFKu1qob7h4LJ5nG_xQvZPkpwbjA@mail.gmail.com>
 <CAM1crw6xAZCWRWovOj3Z=wu3cMcxizo+wjLpTiVOPnSz-hsCxg@mail.gmail.com>
 <CAM1crw5VmdQPxMo1JN-QFaJjoE1c9fqBn0rgD+7CpSHthXdxYw@mail.gmail.com>
 <CAM1crw5LSjNeAk+tKPT5zQ+sOaLSx7cZp0wCDgLouC-cCkZ1sA@mail.gmail.com>
 <CAM1crw6tfUjfGL36_-mOa8GstukOj5mKHqW_gsgzG+46BE2fFw@mail.gmail.com>
 <CAM1crw60DDEoNEgZKdZrAfmO+1DqDz6Sre8CWz5UB6yQfe-7gw@mail.gmail.com>
 <CAM1crw43PbFu9e7KZzKZDor4Y+R8FMNpwSYxVjo9pPkzXb6Q=A@mail.gmail.com>
 <CAM1crw6P67kXy=+v-ji1X8uBiwzwZtD1aMFWUqE=pwfU3wKihw@mail.gmail.com>
 <CAM1crw4ZiSJhaGTpcM2Re_X7Xt4DCqnWswBTsqm+n2VyVE-erQ@mail.gmail.com>
 <CAM1crw5EBd3Q8bt2JA=LoG+Sjg0V1YSbmAtPEE7PqdkZ8KdCMQ@mail.gmail.com>
 <CAM1crw4jCcn68SUH+s8XGnG_L0GntK4NJ7rTpdbd2pkB1HLFSw@mail.gmail.com>
 <CAM1crw7zngDieNh2N_tpJGLNXqybeaw7+nFnjDqzqbi-TadkBw@mail.gmail.com>
 <CAM1crw4gXkaxf1SnBTGX2zuGp9SW5=DfjWuyBQjmpBqy07JoOg@mail.gmail.com>
 <CAM1crw4g9zRT2Z=2q+cuej_C4JqRrTYgKD6pdh6+8HAQjyQMGg@mail.gmail.com>
 <CAM1crw6a+w-9LDRUmvs3vSHR1jJoet2k48OKS+SBojm8KSPh3g@mail.gmail.com>
 <CAM1crw5nhNF+2GXMJN+JPOzzu1_j852ZFd-DzXn-SW91Or5u9Q@mail.gmail.com>
 <CAM1crw40d7gu9DTMHE9EiMVbThfm9=bi5NuTv2eSvdAj9-Do1A@mail.gmail.com>
 <CAM1crw4_=OUGaGPXFmcOBsBu6Mm-7ZoOqoppWecX3PxjnyVquw@mail.gmail.com>
 <CAM1crw7AnBR+VhR9a+bANbeC=Gf9DZy2cGS7anwbeen+TyRL3Q@mail.gmail.com>
 <CAM1crw43kUjDZAOrUmrGSoABCURZx15qfuyBK6jmM0mGVSydoA@mail.gmail.com>
 <CAM1crw5bvwMOWgq8P-yOSStPrtPUqZ=N7M0=9PdUzM8zjb2bxA@mail.gmail.com>
 <CAM1crw6t37fU43+x6YW68M4ubFh96kmMUD_nV5_8FTc23EEOeg@mail.gmail.com>
 <CAM1crw6KOWq1VxUL92MVnYD0ADyxETADvuqhQrnZnCt+6bvUPw@mail.gmail.com>
 <CAM1crw6DdKw3n3WqosBYJoJuunLMRUVnuy5x8DF5S=x38n2iBg@mail.gmail.com> <CAM1crw6342fkzZVVPx8rQUt2p_i6AaaRJr58MaZF8Lj3YoY3Ew@mail.gmail.com>
From:   martin devatta <robertstaylor617@gmail.com>
Date:   Thu, 9 Dec 2021 10:55:52 +0200
Message-ID: <CAM1crw5ML32gDkCZ+waVzDb2RTYhhG1+WnNQ5c_Hai=zhPFzZA@mail.gmail.com>
Subject: From Procurement Supervisor
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

I greet you with warm regards. I work for Malaysia Oil Refinery Sdn
Bhd Company as a procurement supervisor, Malaysia Oil Refinery Sdn Bhd
is an Oil Refining Company located in South East Asia.

On my desk is a mandate to arrange for a Crude Oil purchase from the
National Oil Corporation of Libya, from the State of Libya for up to
2,000,000 (2 Million) barrels on monthly bases for 12 calendar months.

The reason for my reaching out to you is because I am in the process
of establishing a broker / mediator or a middle man structure to
mediate between the 2 parties involved (our Company and the Company in
Libya) before the contract is signed.

You may be wondering why I cannot execute this transaction by myself.
The honest fact is that as an employee working for this company, it is
against our company operational ethics / policy for an employee to be
involved or profit in any financial dealings involving our Company,
hence I am looking for a trustworthy person outside my work circle in
order to maintain a discreet profile.

I wish to extend this partnership to your friend to build a broker /
mediator or a middle man structure with you while I work from the
background to guide you. Our company pays between $ 2 - $ 3 per barrel
of Crude Oil as a commission / brokerage amount, if the target of 2
Million barrels is a monthly we stand to share $ 4 Million - $ 6
Million every month for a span of 12 months .

Contact me if you are interested in this deal, so that I can give you
further details.

Martin  Devatta
Procurement Supervisor
Crude Oil & ProductsTrading Division
Malaysia Oil Refinery Sdn Bhd
Tel: +60 11 1722 5155
E-mail:martindevatta@yandex.com
