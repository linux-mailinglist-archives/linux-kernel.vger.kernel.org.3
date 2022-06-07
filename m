Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD053F7E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiFGIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiFGIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:09:10 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B45A5BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:09:05 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CGQ00057;
        Tue, 07 Jun 2022 16:08:57 +0800
Received: from jtjnmail201622.home.langchao.com (10.100.2.22) by
 jtjnmail201619.home.langchao.com (10.100.2.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 16:08:58 +0800
Received: from jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6])
 by jtjnmail201622.home.langchao.com ([fe80::15c3:8d74:3aa6:25f6%7]) with mapi
 id 15.01.2308.027; Tue, 7 Jun 2022 16:08:58 +0800
From:   =?gb2312?B?Qm8gTGl1ICjB9bKoKS3Ay7Ox0MXPog==?= <liubo03@inspur.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call
Thread-Topic: [PATCH] virtio_ring: remove unnecessary to_vvq call
Thread-Index: Adh6Rag9n4Zh2IYj7kGz6qGzITVEYQ==
Date:   Tue, 7 Jun 2022 08:08:58 +0000
Message-ID: <f5cef070316447cebe0e9c6e86657218@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.104.97]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_0003_01D87A88.E3D30CF0"
MIME-Version: 1.0
tUid:   2022607160857de70f16d74fed340726f2139f3dc611f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0003_01D87A88.E3D30CF0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

This patch removes unnecessary code and generates smaller binary files.
Thanks

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Michael S. Tsirkin <mst@redhat.com>=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2022=C4=EA6=D4=C27=C8=D5 14:38
=CA=D5=BC=FE=C8=CB: Bo Liu (=C1=F5=B2=A8)-=C0=CB=B3=B1=D0=C5=CF=A2 =
<liubo03@inspur.com>
=B3=AD=CB=CD: jasowang@redhat.com; =
virtualization@lists.linux-foundation.org;
linux-kernel@vger.kernel.org
=D6=F7=CC=E2: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call

On Mon, Jun 06, 2022 at 08:59:51PM -0400, Bo Liu wrote:
> In many functions, the parameter passed in is "_vq", which still call
> to_vvq() to get 'vq'. It can avoid unnecessary call of to_vvq() by=20
> directly passing in the parameter "vq".
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>

What does the patch accomplish? Is the generated binary faster? smaller?

> ---
>  drivers/virtio/virtio_ring.c | 100=20
> ++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_ring.c=20
> b/drivers/virtio/virtio_ring.c index 13a7348cedff..f82db59fdbdc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -648,9 +648,8 @@ static inline int virtqueue_add_split(struct =
virtqueue
*_vq,
>  	return -ENOMEM;
>  }
> =20
> -static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 new, old;
>  	bool needs_kick;
> =20
> @@ -667,12 +666,12 @@ static bool virtqueue_kick_prepare_split(struct
virtqueue *_vq)
>  	LAST_ADD_TIME_INVALID(vq);
> =20
>  	if (vq->event) {
> -		needs_kick =3D vring_need_event(virtio16_to_cpu(_vq->vdev,
> +		needs_kick =3D vring_need_event(virtio16_to_cpu(vq->vq.vdev,
>
vring_avail_event(&vq->split.vring)),
>  					      new, old);
>  	} else {
>  		needs_kick =3D !(vq->split.vring.used->flags &
> -					cpu_to_virtio16(_vq->vdev,
> +					cpu_to_virtio16(vq->vq.vdev,
>  						VRING_USED_F_NO_NOTIFY));
>  	}
>  	END_USE(vq);
> @@ -735,11 +734,10 @@ static inline bool more_used_split(const struct
vring_virtqueue *vq)
>  			vq->split.vring.used->idx);
>  }
> =20
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	void *ret;
>  	unsigned int i;
>  	u16 last_used;
> @@ -761,9 +759,9 @@ static void *virtqueue_get_buf_ctx_split(struct
virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
> =20
>  	last_used =3D (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i =3D virtio32_to_cpu(_vq->vdev,
> +	i =3D virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].id);
> -	*len =3D virtio32_to_cpu(_vq->vdev,
> +	*len =3D virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].len);
> =20
>  	if (unlikely(i >=3D vq->split.vring.num)) { @@ -785,7 +783,7 @@ =
static

> void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
> -				cpu_to_virtio16(_vq->vdev,
vq->last_used_idx));
> +				cpu_to_virtio16(vq->vq.vdev,
vq->last_used_idx));
> =20
>  	LAST_ADD_TIME_INVALID(vq);
> =20
> @@ -793,10 +791,8 @@ static void *virtqueue_get_buf_ctx_split(struct
virtqueue *_vq,
>  	return ret;
>  }
> =20
> -static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUPT;
>  		if (vq->event)
> @@ -804,14 +800,13 @@ static void virtqueue_disable_cb_split(struct
virtqueue *_vq)
>  			vring_used_event(&vq->split.vring) =3D 0x0;
>  		else
>  			vq->split.vring.avail->flags =3D
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>
vq->split.avail_flags_shadow);
>  	}
>  }
> =20
> -static unsigned int virtqueue_enable_cb_prepare_split(struct=20
> virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_split(struct=20
> +vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 last_used_idx;
> =20
>  	START_USE(vq);
> @@ -825,26 +820,23 @@ static unsigned int
virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
>  		vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =3D
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>
vq->split.avail_flags_shadow);
>  	}
> -	vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(_vq->vdev,
> +	vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(vq->vq.vdev,
>  			last_used_idx =3D vq->last_used_idx);
>  	END_USE(vq);
>  	return last_used_idx;
>  }
> =20
> -static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int=20
> last_used_idx)
> +static bool virtqueue_poll_split(struct vring_virtqueue *vq, unsigned =

> +int last_used_idx)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
> -	return (u16)last_used_idx !=3D virtio16_to_cpu(_vq->vdev,
> +	return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->idx);
>  }
> =20
> -static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue=20
> +*vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 bufs;
> =20
>  	START_USE(vq);
> @@ -858,7 +850,7 @@ static bool =
virtqueue_enable_cb_delayed_split(struct
virtqueue *_vq)
>  		vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTERRUPT;
>  		if (!vq->event)
>  			vq->split.vring.avail->flags =3D
> -				cpu_to_virtio16(_vq->vdev,
> +				cpu_to_virtio16(vq->vq.vdev,
>
vq->split.avail_flags_shadow);
>  	}
>  	/* TODO: tune this threshold */
> @@ -866,9 +858,9 @@ static bool=20
> virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> =20
>  	virtio_store_mb(vq->weak_barriers,
>  			&vring_used_event(&vq->split.vring),
> -			cpu_to_virtio16(_vq->vdev, vq->last_used_idx +
bufs));
> +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx +
bufs));
> =20
> -	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev,
vq->split.vring.used->idx)
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,=20
> +vq->split.vring.used->idx)
>  					- vq->last_used_idx) > bufs)) {
>  		END_USE(vq);
>  		return false;
> @@ -878,9 +870,8 @@ static bool =
virtqueue_enable_cb_delayed_split(struct
virtqueue *_vq)
>  	return true;
>  }
> =20
> -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue =

> +*vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
> =20
> @@ -893,7 +884,7 @@ static void =
*virtqueue_detach_unused_buf_split(struct
virtqueue *_vq)
>  		buf =3D vq->split.desc_state[i].data;
>  		detach_buf_split(vq, i, NULL);
>  		vq->split.avail_idx_shadow--;
> -		vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> +		vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vdev,
>  				vq->split.avail_idx_shadow);
>  		END_USE(vq);
>  		return buf;
> @@ -1296,9 +1287,8 @@ static inline int virtqueue_add_packed(struct
virtqueue *_vq,
>  	return -EIO;
>  }
> =20
> -static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>  	bool needs_kick;
>  	union {
> @@ -1410,11 +1400,10 @@ static inline bool more_used_packed(const =
struct
vring_virtqueue *vq)
>  			vq->packed.used_wrap_counter);
>  }
> =20
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 last_used, id;
>  	void *ret;
> =20
> @@ -1475,10 +1464,8 @@ static void =
*virtqueue_get_buf_ctx_packed(struct
virtqueue *_vq,
>  	return ret;
>  }
> =20
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>  	if (vq->packed.event_flags_shadow !=3D
VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow =3D
VRING_PACKED_EVENT_FLAG_DISABLE;
>  		vq->packed.vring.driver->flags =3D
> @@ -1486,10 +1473,8 @@ static void virtqueue_disable_cb_packed(struct
virtqueue *_vq)
>  	}
>  }
> =20
> -static unsigned int virtqueue_enable_cb_prepare_packed(struct=20
> virtqueue *_vq)
> +static unsigned int virtqueue_enable_cb_prepare_packed(struct=20
> +vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>  	START_USE(vq);
> =20
>  	/*
> @@ -1522,9 +1507,8 @@ static unsigned int
virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  			VRING_PACKED_EVENT_F_WRAP_CTR);
>  }
> =20
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, u16=20
> off_wrap)
> +static bool virtqueue_poll_packed(struct vring_virtqueue *vq, u16=20
> +off_wrap)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	bool wrap_counter;
>  	u16 used_idx;
> =20
> @@ -1534,9 +1518,8 @@ static bool virtqueue_poll_packed(struct =
virtqueue
*_vq, u16 off_wrap)
>  	return is_used_desc_packed(vq, used_idx, wrap_counter);  }
> =20
> -static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue =

> +*vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	u16 used_idx, wrap_counter;
>  	u16 bufs;
> =20
> @@ -1593,9 +1576,8 @@ static bool
virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  	return true;
>  }
> =20
> -static void *virtqueue_detach_unused_buf_packed(struct virtqueue=20
> *_vq)
> +static void *virtqueue_detach_unused_buf_packed(struct=20
> +vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq =3D to_vvq(_vq);
>  	unsigned int i;
>  	void *buf;
> =20
> @@ -1906,8 +1888,8 @@ bool virtqueue_kick_prepare(struct virtqueue=20
> *_vq)  {
>  	struct vring_virtqueue *vq =3D to_vvq(_vq);
> =20
> -	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
> -				 virtqueue_kick_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> +				 virtqueue_kick_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> =20
> @@ -1977,8 +1959,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue=20
> *_vq, unsigned int *len,  {
>  	struct vring_virtqueue *vq =3D to_vvq(_vq);
> =20
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx)
:
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx)
:
> +				 virtqueue_get_buf_ctx_split(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> =20
> @@ -2007,9 +1989,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  		return;
> =20
>  	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(_vq);
> +		virtqueue_disable_cb_packed(vq);
>  	else
> -		virtqueue_disable_cb_split(_vq);
> +		virtqueue_disable_cb_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> =20
> @@ -2032,8 +2014,8 @@ unsigned int virtqueue_enable_cb_prepare(struct
virtqueue *_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered =3D false;
> =20
> -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> -				 virtqueue_enable_cb_prepare_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> +				 virtqueue_enable_cb_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> =20
> @@ -2054,8 +2036,8 @@ bool virtqueue_poll(struct virtqueue *_vq, =
unsigned
int last_used_idx)
>  		return false;
> =20
>  	virtio_mb(vq->weak_barriers);
> -	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
> -				 virtqueue_poll_split(_vq, last_used_idx);
> +	return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> +				 virtqueue_poll_split(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
> =20
> @@ -2098,8 +2080,8 @@ bool virtqueue_enable_cb_delayed(struct =
virtqueue
*_vq)
>  	if (vq->event_triggered)
>  		vq->event_triggered =3D false;
> =20
> -	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
> -				 virtqueue_enable_cb_delayed_split(_vq);
> +	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> +				 virtqueue_enable_cb_delayed_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> =20
> @@ -2115,8 +2097,8 @@ void *virtqueue_detach_unused_buf(struct=20
> virtqueue *_vq)  {
>  	struct vring_virtqueue *vq =3D to_vvq(_vq);
> =20
> -	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> -				 virtqueue_detach_unused_buf_split(_vq);
> +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> +				 virtqueue_detach_unused_buf_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> =20
> --
> 2.27.0


------=_NextPart_000_0003_01D87A88.E3D30CF0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBTk
Hdp/y3+DuDJ13Q1YzgU9iV7NdzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8G
A1UdHwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIu
aG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEE
ggEbMIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVi
bGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21l
LERDPWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlm
aWNhdGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2No
YW8uY29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNy
dDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSbGl1Ym8wM0BpbnNwdXIuY29tgRJsaXVibzAz
QGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAA+BaY3B3qXmvZq7g7tZLzq2VQjU//XHTmyl
58GLDWdVHsuX3lrAGwEfLVnUodpvthjtb7T7xEUzJh4F62zLFSm8HOBPH1B+6SFQKChHZeM0pauv
Xr1krRtVv82RgLsU26XrXFUPN+NcPwt7vOw1zHOiDic4anL3A9gsuDljAi2l+CA5RY05yL+8oras
EAhOYL6+ks9aB8QiCxbZzShkDTMkrh0N1DjoBLaibtnlI/fxOUYM6vgdiI+FC02G41B364ZAc1ma
bSFvGIP6cIdr/olprPQOj9cq6zMi05qUBUj22hDvhcY0TlT4fEJSrvblp/LG6qTtVI3ilUAxhe8i
9cIxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghs
YW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHV
TGwIT1/wiwAAAADR0TAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMjA2MDcwODA4NTZaMCMGCSqGSIb3DQEJBDEWBBSs7WbHOlDqYF20YMXY
dIZi5/mOWzB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJ
k/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1D
QQITfgAA0dHVTGwIT1/wiwAAAADR0TCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJk/Is
ZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUx
EjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0dHVTGwIT1/wiwAAAADR0TCBkwYJKoZIhvcNAQkPMYGF
MIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBuDksMlhysTdVdStkY4+m/Hebv
TIfe6t5cdya6SPUJugUXK39Js7XJMOTYtJkKZsyyScFXmVGORjoRwqWLsOPSNTvkJlhq3sSzgOi5
yLpgTCZt0Eu67iISaYu7iJJkha+o5gSfD6ndyrreLqQZpxLM8SWEqbnMCU3NfpnGPtnmX8Nb0O4e
HKym1A8bMj4oAdeNzRNL9qIv+Dnd7TZbmJ2iUsYt6/RJqabvglrLQ+RDQp3uEe0Q30OBixCy8Nyh
KojIXSZt68+aCl9pXP6BzJiFQU+j+YHLEPebKJimVC9U2+T5vdy95Q415wBG1UshAcBiYzTH8j05
Fnbb+AnTfLMoAAAAAAAA

------=_NextPart_000_0003_01D87A88.E3D30CF0--
